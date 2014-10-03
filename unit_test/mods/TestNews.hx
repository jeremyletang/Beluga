package mods;

import hunit.Assert;
import hunit.AssertException;
import hunit.HUnitTest;

import beluga.core.Beluga;
import beluga.module.news.News;

import php.Lib;
import sys.db.Types;

class TestNews implements HUnitTest {
    public var news: News;
    public static var beluga: Beluga;

    public function new() {}

    @before
    public function beforeTest() {
        beluga = Beluga.getInstance();
        news = beluga.getModuleInstance(News);
    }

    @test
    public function testRedirectTrigger() {
        this.news.triggers.redirect.add(this.catchRedirect);
        this.news.triggers.redirect.dispatch();
    }
    public function catchRedirect() {}

    @test
    public function testRedirectEditTrigger() {
        this.news.triggers.redirectEdit.add(this.catchRedirectEdit);
        this.news.triggers.redirectEdit.dispatch({news_id: 1});
    }
    public function catchRedirectEdit(args: {news_id: Int}) {
        Assert.eq(args.news_id, 1);
    }

    @test
    public function testDefaultNewsTrigger() {
        this.news.triggers.defaultNews.add(this.catchDefaultNews);
        this.news.triggers.defaultNews.dispatch();
    }
    public function catchDefaultNews() {}

    @test
    public function testPrintTrigger() {
        this.news.triggers.print.add(this.catchPrint);
        this.news.triggers.print.dispatch({news_id: 1});
    }
    public function catchPrint(args: {news_id: Int}) {
        Assert.eq(args.news_id, 1);
    }

    @test
    public function testEditFailTrigger() {
        this.news.triggers.editFail.add(this.catchEditFail);
        this.news.triggers.editFail.dispatch({news_id: 2});
    }
    public function catchEditFail(args: {news_id: Int}) {
        Assert.eq(args.news_id, 2);
    }

    @test
    public function testEditSuccessTrigger() {
        this.news.triggers.editSuccess.add(this.catchEditSuccess);
        this.news.triggers.editSuccess.dispatch({news_id: 2});
    }
    public function catchEditSuccess(args: {news_id: Int}) {
        Assert.eq(args.news_id, 2);
    }

    @test
    public function testAddCommentFailTrigger() {
        this.news.triggers.addCommentFail.add(this.catchAddCommentFail);
        this.news.triggers.addCommentFail.dispatch({news_id: 2});
    }
    public function catchAddCommentFail(args: {news_id: Int}) {
        Assert.eq(args.news_id, 2);
    }

    @test
    public function testAddCommentSuccessTrigger() {
        this.news.triggers.addCommentSuccess.add(this.catchAddCommentSuccess);
        this.news.triggers.addCommentSuccess.dispatch({news_id: 2});
    }
    public function catchAddCommentSuccess(args: {news_id: Int}) {
        Assert.eq(args.news_id, 2);
    }

    @test
    public function testDeleteCommentSuccessTrigger() {
        this.news.triggers.deleteCommentSuccess.add(this.catchDeleteCommentSuccess);
        this.news.triggers.deleteCommentSuccess.dispatch({news_id: 2 });
    }
    public function catchDeleteCommentSuccess(args: {news_id: Int}) {
        Assert.eq(args.news_id, 2);
    }

    @test
    public function testDeleteCommentFailTrigger() {
        this.news.triggers.deleteCommentFail.add(this.catchDeleteCommentFail);
        this.news.triggers.deleteCommentFail.dispatch({news_id: 2});
    }
    public function catchDeleteCommentFail(args: {news_id: Int}) {
        Assert.eq(args.news_id, 2);
    }

    @test
    public function testDeleteSuccessTrigger() {
        this.news.triggers.deleteSuccess.add(this.catchDeleteSuccess);
        this.news.triggers.deleteSuccess.dispatch();
    }
    public function catchDeleteSuccess() {}

    @test
    public function testDeleteFailTrigger() {
        this.news.triggers.deleteFail.add(this.catchDeleteFail);
        this.news.triggers.deleteFail.dispatch({news_id: 2});
    }
    public function catchDeleteFail(args: {news_id: Int}) {}

    @test
    public function testCreateFailTrigger() {
        this.news.triggers.createFail.add(this.catchCreateFail);
        this.news.triggers.createFail.dispatch();
    }
    public function catchCreateFail() {
    }
}
