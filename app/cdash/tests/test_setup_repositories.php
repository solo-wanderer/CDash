<?php
//
// After including cdash_selenium_test_base.php, subsequent require_once calls
// are relative to the top of the CDash source tree
//
require_once dirname(__FILE__) . '/cdash_test_case.php';


use CDash\Model\Project;

class SetupRepositoriesTestCase extends KWWebTestCase
{
    public function __construct()
    {
        parent::__construct();
    }

    public function testSetupRepositories()
    {
        $insight = new Project();
        $row = pdo_single_row_query("SELECT id FROM project where name='InsightExample'");
        $insight->Id = $row['id'];
        $insight->Fill();
        $insight->AddRepositories(
            [':pserver:anoncvs@itk.org:/cvsroot/Insight'], ['anoncvs'], [''], ['']);
        $insight->CTestTemplateScript = 'client testing works';
        $insight->Save();

        $pub = new Project();
        $row = pdo_single_row_query("SELECT id FROM project where name='PublicDashboard'");
        $pub->Id = $row['id'];
        $pub->Fill();
        $pub->AddRepositories(
            ['git://cmake.org/cmake.git'], [''], [''], ['']);
        $pub->CvsViewerType = 'gitweb';
        $pub->CvsUrl ='cmake.org/gitweb?p=cmake.git';
        $pub->Save();

        $email = new Project();
        $row = pdo_single_row_query("SELECT id FROM project where name='EmailProjectExample'");
        $email->Id = $row['id'];
        $email->Fill();
        $email->AddRepositories(
            ['https://www.kitware.com/svn/CDash/trunk'], [''], [''], ['']);
        $pub->CvsViewerType = 'websvn';
        $email->CvsUrl = 'https://www.kitware.com/svn/CDash/trunk';
        $email->Save();
    }
}
