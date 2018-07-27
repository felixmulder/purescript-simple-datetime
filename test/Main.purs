module Test.Main where

import Prelude
import Effect (Effect)
import Data.Either (isRight, fromRight)

import Data.SimpleDateTime as SD
import Partial.Unsafe (unsafePartial)

import Test.Spec.Runner (run)
import Test.Spec (describe, it)
import Test.Spec.Assertions (shouldEqual)
import Test.Spec.Reporter.Console (consoleReporter)

main :: Effect Unit
main = run [consoleReporter] do
  describe "SimpleDateTime spec" do
    it "should parse valid ISO UTC dates" do
      isRight parsedUTCDate1 `shouldEqual` true
      isRight parsedUTCDate2 `shouldEqual` true

    it "should be able to parse using ISO format" do
      isRight parsedDate1 `shouldEqual` true
      isRight parsedDate2 `shouldEqual` true

    let date1 = fromEither parsedUTCDate1
    let date2 = fromEither parsedUTCDate2

    it "should be able to get the correct hour" do
      SD.getHours date1 `shouldEqual` 16
      SD.getHours date2 `shouldEqual` 8

    it "should be able to get the correct minute" do
      SD.getMinutes date1 `shouldEqual` 20
      SD.getMinutes date2 `shouldEqual` 0

    it "should be able to get the correct seconds" do
      SD.getSeconds date1 `shouldEqual` 38
      SD.getSeconds date2 `shouldEqual` 12

  where fromEither = unsafePartial $ fromRight

        isoDateUTC1 = "2018-07-27T16:20:38.469Z"
        isoDateUTC2 = "2018-07-27T08:00:12.469Z"

        parsedUTCDate1 = SD.parse isoDateUTC1
        parsedUTCDate2 = SD.parse isoDateUTC2

        isoDate1 = "2018-07-27T16:20:38.469"
        isoDate2 = "2018-07-27T08:00:12.469"

        isoFormat = SD.DateFormat "YYYY-MM-DDTHH:mm:ss.SSS"
        parsedDate1 = SD.parseFormat isoFormat isoDate1
        parsedDate2 = SD.parseFormat isoFormat isoDate2
