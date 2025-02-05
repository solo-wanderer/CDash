require('../pages/catchConsoleErrors.page.js');
describe("viewBuildError", function() {

  it("shows 0 errors'", function() {
    browser.get('viewBuildError.php?buildid=7');
    expect(element(by.className('num-errors')).getText()).toContain("0 Errors");
  });

  it("deltan shows 0 errors'", function() {
    browser.get('viewBuildError.php?buildid=7&onlydeltan=1');
    expect(element(by.className('num-errors')).getText()).toContain("0 Errors");
  });

  it("deltap shows 0 errors'", function() {
    browser.get('viewBuildError.php?buildid=7&onlydeltap=1');
    expect(element(by.className('num-errors')).getText()).toContain("0 Errors");
  });

  it("type=1 shows 10 warnings", function() {
    browser.get('viewBuildError.php?buildid=7&type=1');
    expect(element(by.className('num-errors')).getText()).toContain("10 Warnings");
  });

  it("displays build errors inline", function() {
    browser.get('viewBuildError.php?buildid=74&type=0');
    expect(browser.getPageSource()).toContain("error: 'foo' was not declared in this scope");
  });

  it("displays build errors inline on parent builds", function() {
    browser.get('viewBuildError.php?buildid=73&type=0');
    expect(browser.getPageSource()).toContain("some-test-subproject");
    expect(browser.getPageSource()).toContain("error: 'foo' was not declared in this scope");
  });

  it("colorizes output", function() {
    var outputXpath = '//pre[@ng-bind-html="error.precontext | ctestNonXmlCharEscape | terminalColors:false | trustAsHtml"]';

    browser.get('index.php?project=OutputColor&date=2018-01-26');
    element(by.linkText('5')).click();
    expect(element.all(by.xpath(outputXpath + '/span')).count()).toBe(2);
    expect(browser.getPageSource()).toContain('&lt;a href="https://www.kitware.com/"&gt;Kitware&lt;\/a&gt;');
  });
});
