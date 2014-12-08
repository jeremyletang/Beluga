package mods;

import hunit.Assert;
import hunit.AssertException;
import hunit.HUnitTest;

import beluga.Beluga;
import beluga.module.survey.Survey;

import php.Lib;
import sys.db.Types;

class TestSurvey implements HUnitTest {
    public var survey: Survey;
    public static var beluga: Beluga;

    public function new() {}

    @before
    public function beforeTest() {
        beluga = Beluga.getInstance();
        survey = beluga.getModuleInstance(Survey);
    }

    
}
