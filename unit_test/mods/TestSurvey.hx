package mods;

import hunit.Assert;
import hunit.AssertException;
import hunit.HUnitTest;

import beluga.core.Beluga;
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

    @test
    public function testRedirectTrigger() {
        this.survey.triggers.redirect.add(this.catchRedirect);
        this.survey.triggers.redirect.dispatch();
    }
    public function catchRedirect() {}

    @test
    public function testDeleteFailTrigger() {
        this.survey.triggers.deleteFail.add(this.catchDeleteFail);
        this.survey.triggers.deleteFail.dispatch();
    }
    public function catchDeleteFail() {}

    @test
    public function testDeleteSuccessTrigger() {
        this.survey.triggers.deleteSuccess.add(this.catchDeleteSuccess);
        this.survey.triggers.deleteSuccess.dispatch();
    }
    public function catchDeleteSuccess() {}

    @test
    public function testPrintSurveyTrigger() {
        this.survey.triggers.printSurvey.add(this.catchPrintSurvey);
        this.survey.triggers.printSurvey.dispatch({survey_id : 1});
    }
    public function catchPrintSurvey(args: {survey_id : Int}) {
        Assert.eq(args.survey_id, 1);
    }

    @test
    public function testCreateFailTrigger() {
        this.survey.triggers.createFail.add(this.catchCreateFail);
        this.survey.triggers.createFail.dispatch();
    }
    public function catchCreateFail() {}

    @test
    public function testCreateSuccessTrigger() {
        this.survey.triggers.createSuccess.add(this.catchCreateSuccess);
        this.survey.triggers.createSuccess.dispatch();
    }
    public function catchCreateSuccess() {}

    @test
    public function testVoteFailTrigger() {
        this.survey.triggers.voteFail.add(this.catchVoteFail);
        this.survey.triggers.voteFail.dispatch({survey: 1});
    }
    public function catchVoteFail(args: { survey : Int }) {
        Assert.eq(args.survey, 1);
    }

    @test
    public function testVoteSuccessTrigger() {
        this.survey.triggers.voteSuccess.add(this.catchVoteSuccess);
        this.survey.triggers.voteSuccess.dispatch();
    }
    public function catchVoteSuccess() {}

    @test
    public function testAnswerNotifyTrigger() {
        this.survey.triggers.answerNotify.add(this.catchAnswerNotify);
        this.survey.triggers.answerNotify.dispatch({title: "title", text: "text", user_id: 2});
    }
    public function catchAnswerNotify(args: {title: String, text: String, user_id: SId}) {
        Assert.eq(args.title, "title");
        Assert.eq(args.text, "text");
        Assert.eq(args.user_id, 2);
    }

    @test
    public function testDefaultSurveyTrigger() {
        this.survey.triggers.defaultSurvey.add(this.catchDefaultSurvey);
        this.survey.triggers.defaultSurvey.dispatch();
    }
    public function catchDefaultSurvey() {}
}
