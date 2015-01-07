# i18n-edit

[![Build Status](https://travis-ci.org/pixta-dev/i18n-edit.svg?branch=master)](https://travis-ci.org/pixta-dev/i18n-edit)

A desktop tool for editing i18n yaml files (like in Rails).

Built on node-webkit

## Requirements

* node-webkit 0.10+

## UI Language

* Japanese
* TODO: English

## Development

### Prepare

* Install Node.js
* Install node-webkit

```
npm install
npm install -g gulp
npm install -g bower
```

### Watch and build files

```
gulp
```

### Run

```
nw .
DEBUG=1 nw . # show dev tools
```

### Package app

```
gulp deploy
```
