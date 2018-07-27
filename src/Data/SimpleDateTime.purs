module Data.SimpleDateTime
  ( SimpleDateTime
  , DateFormat(..)
  , parse
  , parseFormat
  , getHours
  , getMinutes
  , getSeconds
  )
  where

import Prelude (class Show, map, show, (<<<), (<>), (>>>), ($))

import Effect.Exception (Error, error)
import Data.Bifunctor (bimap)
import Data.Either (Either)
import Data.JSDate (JSDate)
import Data.JSDate as JSD
import Data.Formatter.DateTime as FDT
import Data.DateTime.Instant (fromDateTime)
import Data.Int (floor)

newtype SimpleDateTime = SimpleDateTime JSDate

--| A newtype wrapper for a format that should be used to parse a `SimpleDateTime`
--|
--| An example format is the `isoUtc` format defined as defined below
newtype DateFormat = DateFormat String

--| A standard date format with maximum precision for JS
isoUtc :: DateFormat
isoUtc = DateFormat "YYYY-MM-DDTHH:mm:ss.SSSZ"

instance showSimpleDateTime :: Show SimpleDateTime where
  show (SimpleDateTime d) = "SimpleDateTime" <> show d

--| Parses an ISO 8601 UTC date on the format `YYYY-MM-DDTHH:mm:ss.SSSZ` to a
--| `SimpleDateTime`
parse :: String -> Either Error SimpleDateTime
parse = parseFormat isoUtc

--| Parses a string using a specific `DateFormat`
parseFormat :: DateFormat -> String -> Either Error SimpleDateTime
parseFormat (DateFormat df) =
  FDT.unformatDateTime df >>>
  bimap error fromDateTime >>>
  map (SimpleDateTime <<< JSD.fromInstant)

--| Get the year from a `SimpleDateTime`
getYear :: SimpleDateTime -> Int
getYear (SimpleDateTime jd) = floor $ JSD.getUTCFullYear jd

--| Get the month from a `SimpleDateTime`
getMonth :: SimpleDateTime -> Int
getMonth (SimpleDateTime jd) = floor $ JSD.getUTCMonth jd

--| Get the date of the month from a `SimpleDateTime`
getDate :: SimpleDateTime -> Int
getDate (SimpleDateTime jd) = floor $ JSD.getUTCDate jd

--| Get the day of the week from a `SimpleDateTime`
getDay :: SimpleDateTime -> Int
getDay (SimpleDateTime jd) = floor $ JSD.getUTCDay jd

--| Get the hours from a `SimpleDateTime`
getHours :: SimpleDateTime -> Int
getHours (SimpleDateTime jd) = floor $ JSD.getUTCHours jd

--| Get the minutes from a `SimpleDateTime`
getMinutes :: SimpleDateTime -> Int
getMinutes (SimpleDateTime jd) = floor $ JSD.getUTCMinutes jd

--| Get the seconds from a `SimpleDateTime`
getSeconds :: SimpleDateTime -> Int
getSeconds (SimpleDateTime jd) = floor $ JSD.getUTCSeconds jd

--| Get the milliseconds from a `SimpleDateTime`
getMillis :: SimpleDateTime -> Int
getMillis (SimpleDateTime jd) = floor $ JSD.getUTCMilliseconds jd
