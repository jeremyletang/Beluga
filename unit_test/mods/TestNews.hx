package mods;

import hunit.Assert;
import hunit.AssertException;
import hunit.HUnitTest;

import beluga.Beluga;
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
}
