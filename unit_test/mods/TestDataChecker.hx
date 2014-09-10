package mods;

import hunit.Assert;
import hunit.HUnitTest;

import beluga.core.form.DataChecker;

class TestDataChecker implements HUnitTest {
    public function new(){}

    @test
    public function testExample() {
        Assert.isTrue(true);
    }

    @test
    public function checkMinValueIsBiggerThanFormValueTrue() {
        var test_result = DataChecker.checkMinValue(42, 84);
        Assert.isTrue(test_result);
    }

    @test
    public function checkMinValueIsBiggerThanFormValueFalse(): Void {
        var test_result = DataChecker.checkMinValue(84, 42);
        Assert.isFalse(test_result);
    }

    @test
    public function checkFormValueIsBiggerThanMinValueTrue(): Void {
        var test_result = DataChecker.checkMaxValue(84, 42);
        Assert.isTrue(test_result);
    }

    @test
    public function checkFormValueIsBiggerThanMinValueFalse(): Void {
        var test_result = DataChecker.checkMaxValue(42, 84);
        Assert.isFalse(test_result);
    }

    @test
    public function checkFormValueIsInTheRange(): Void {
        var test_result = DataChecker.checkRangeValue(84, 42, 128);
        Assert.isFalse(test_result);
    }

    @test
    public function checkFormValueIsNotInTheRange(): Void {
        var test_result = DataChecker.checkRangeValue(42, 84, 128);
        Assert.isFalse(test_result);
    }

    @test
    public function checkFormValueIsEqualToGivenValue(): Void {
        var test_result = DataChecker.checkEqualValue(84, 84);
        Assert.isTrue(test_result);
    }

    @test
    public function checkFormValueIsNotEqualToGivenValue(): Void {
        var test_result = DataChecker.checkEqualValue(42, 84);
        Assert.isFalse(test_result);
    }

    @test
    public function checkFormValueHasAtLeastTheMinimalLength(): Void {
        var test_result = DataChecker.checkMinLength("hello", 3);
        Assert.isTrue(test_result);
    }

    @test
    public function checkFormValueHasNotTheMinimalLength(): Void {
        var test_result = DataChecker.checkMinLength("hello", 8);
        Assert.isFalse(test_result);
    }

    @test
    public function checkFormValueHasAtLeastTheMaxLength(): Void {
        var test_result = DataChecker.checkMaxLength("hello", 3);
        Assert.isFalse(test_result);
    }

    @test
    public function checkFormValueHasNotTheMaxLength(): Void {
        var test_result = DataChecker.checkMaxLength("hello", 8);
        Assert.isTrue(test_result);
    }

    @test
    public function checkFormValueHasEqualLength(): Void {
        var test_result = DataChecker.checkEqualLength("hello", 5);
        Assert.isTrue(test_result);
    }

    @test
    public function checkFormValueHasNotEqualLength(): Void {
        var test_result = DataChecker.checkEqualLength("hello", 8);
        Assert.isFalse(test_result);
    }

    @test
    public function checkPatternMatch(): Void {
        var filter:EReg = ~/[A-Z0-9._%-]+@[A-Z0-9.-]+\.[A-Z][A-Z][A-Z]?/i;
        var test_result = DataChecker.checkMatch("john.doe@gmain.com", filter);
        Assert.isTrue(test_result);
    }

    @test
    public function checkPatternDontMatch(): Void {
        var filter:EReg = ~/[A-Z0-9._%-]+@[A-Z0-9.-]+\.[A-Z][A-Z][A-Z]?/i;
        var test_result = DataChecker.checkMatch("blah blah blah", filter);
        Assert.isFalse(test_result);
    }
}