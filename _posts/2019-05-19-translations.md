---
published: true
layout: post
date: "2019-05-19"
categories: blog
title: Automated i18n Translations with NodeJS and Google Cloud
---

At work I deal with a very large scale application that we deploy in a lot of different markets. A lot of these markets speak different languages. We get a lot of human-made translations for our i18n but sometimes we need to fill in the cracks and get translations we don't have. Some of our devs were putting i18n labels into Google Translate as a quick fix but this was a tedius process sometimes. I thought it would be neat if we could just run `npm run translate` whenever we needed and be done with it.

To solve this problem I needed two things. Google Cloud and a way quickly find all the English i18n JSON elements that were missing in the corresponding foreign langauge JSON files. I basically did this with two interesting node packages, a lot of loops, lots of file I/O, and some async/await stuff.

## Dependencies
Two external packages were kind of instrumental to this.

```javascript
const Translate = require('@google-cloud/translate');
const diff = require('deep-diff');
```

You can probably guess what the [Google Cloud Translation API](https://cloud.google.com/translate/) does. An npm package I found, [deep-diff by fillbit](https://github.com/flitbit/diff), compares two JSON objects and returns every the type and path of every discrepency between them. This was exactly what I needed for my specific needs.

```javascript
 translateDiff: async function(original, translation, isoCode) {
        try {
            const changeset = diff.diff(original, translation);
            let index = 0;

            for (change of changeset)  {
                if (change.kind === 'D') {
                    ...
```

The actual diff part is completely handled by deep-diff. Once we have that `changeset` const it's off to the races to try and figure out what needs translating. More specifically, what we're looking for here is any JSON key that appears in the "default" object but doesn't appear in the "translation" object. We're trying to avoid tampering with any translated labels that already exist because we don't want to overwrite any human-translated text.


## Async/Await and File I/O
I mostly wanted this to also be a good way for me to really get my hands dirty with ES6 and get a better idea of how to use asynchronous methods with `async` and `await`. [ES6 async functions](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Statements/async_function) are pretty cool!

```javascript
for (file of i18nConfig.files) {
    const input = JSON.parse(await readFile(this.i18nPath + 'default/' + file + '.json', 'utf8'));
    const filename = this.i18nPath + culture.name + '/' + file + '.json';
    let current = {};

    if (await exists(filename)) {
        current = JSON.parse(await readFile(filename, 'utf8'));
    } else {
        current[file] = {};
    }

    const translation = await this.translateDiff(input, current, culture.isoCode);
    await writeFile(filename, JSON.stringify(translation, null, '    '), 'utf8');
    console.log(' > ' + filename);
}
```

deep-diff also manages to return an array of the keys in the path of each JSON discrepancy which makes it relatively easy to programatically figure out where the missing translation needs to go. The i18n I was working with would sometimes have label text and different levels so I had to account for all the different cases. This is where the actually really involved part happens.

```javascript
if (typeof change.lhs === 'string') {
    if (change.path.length === 3) {
        translation[change.path[0]][change.path[1]][change.path[2]] = await this.translateString(change.lhs, isoCode);
    } else if (change.path.length === 4) {
        translation[change.path[0]][change.path[1]][change.path[2]][change.path[3]] = await this.translateString(change.lhs, isoCode);
    }
} else {
    const diffKeys = Object.keys(change.lhs);
    for (key of diffKeys) {
        if (change.path.length === 2) {
            if (translation[change.path[0]][change.path[1]] === undefined) {
                translation[change.path[0]][change.path[1]] = {};
            }
            if (typeof change.lhs[key] !== 'string') {
                translation[change.path[0]][change.path[1]][key] = {};

                const subDiffKeys = Object.keys(change.lhs[key]);
                for (subKey of subDiffKeys) {
                    translation[change.path[0]][change.path[1]][key][subKey] = await this.translateString(change.lhs[key][subKey], isoCode);
                }
            } else {
                translation[change.path[0]][change.path[1]][key] = await this.translateString(change.lhs[key], isoCode);
            }
        } else if (change.path.length === 3) {
            if (translation[change.path[0]][change.path[1]][change.path[2]] === undefined) {
                translation[change.path[0]][change.path[1]][change.path[2]] = {};
            }
            translation[change.path[0]][change.path[1]][change.path[2]][key] = await this.translateString(change.lhs[key], isoCode);
        }
    }
}
```

## Translate
After finally determining what text actually needs to get translated and where it needs to go it's time to translate it. This is probably the easiest part once it's all together.

```javascript
translateString: async function(string, language) {
    try {
        const results = await translator.translate(string, language);
        return results[0];
    } catch (err) {
        console.error('ERROR:', err);
        throw(err);
    }
},
```

You can check out the finished script [by clicking here.](https://github.com/kmrn/amulet)