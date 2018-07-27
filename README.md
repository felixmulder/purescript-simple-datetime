# purescript-simple-datetime
[![Build status](https://travis-ci.org/felixmulder/purescript-simple-datetime.svg?branch=master)](https://travis-ci.org/felixmulder/purescript-simple-datetime)

A simplified version of DateTime

## Installation
```bash
$ bower install purescript-simple-datetime --save
```

## Parsing a date
If your date is on the format `"YYYY-MM-DDTHH:mm:ss.SSSZ"` then you can simply do:

```purescript
import Data.SimpleDateTime
import Data.SimpleDateTime as SDT
import Effect.Exception (Error)

parsedDate :: Either Error SimpleDateTime
parsedDate = SDT.parse "2018-07-27T16:20:38.469"
```
## Parsing from a custom format
Parsing from your own format, let's say: `"YYYY-MM-DD"` is as simple as:

```purescript
format :: SDT.DateFormat
format = SDT.DateFormat "YYYY-MM-DD"

parsedDate :: Either Error SimpleDateTime
parsedDate = SDT.parseFormat format "2018-01-14"
```

## Using `SimpleDateTime`
Standard functions for getting the time, date, day of the week etc all exist on
this simple type:

```purescript
hours :: SimpleDateTime -> Int
hours = SDT.getHours

minutes :: SimpleDateTime -> Int
minutes = SDT.getMinutes
```
