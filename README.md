# dbb-pipeline
This repository contains examples of CI/CD pipeline scripts integrated with IBM Dependency Based Build (DBB).

## Build a pipeline with Jenkins, Dependency Based Build and UrbanCode Deploy

This `cics-genapp` folder contains the DBB application configuration folder and the Jenkins pipeline file related to this tutorial https://developer.ibm.com/components/ibmz/tutorials/build-a-pipeline-with-jenkins-dependency-based-build-and-urbancode-deploy/. It shows how to build the pipeline with all the products installed. You can also experiment a GitLab CI pipeline by following instructions in this tutorial https://developer.ibm.com/tutorials/build-a-pipeline-with-gitlab-ci-dbb-and-ucd/.

Theses tutorials focus on showing how to integrate UCD into a development pipeline to streamline the development of applications. It explains the UCD configuration steps in detail and shows how to quickly test the configuration by starting a Jenkins or GitLab CI build that runs a Dependency Based Build (DBB) build with zUnit, code coverage and IDz code review. This build will create a version in the client UCD, upload the binary files to Artifactory, and deploy the application via UCD, using the binary files in Artifactory.

We also provide an export of the UrbanCode Deploy GenApp application. This export comes from UrbanCode Deploy version  `7.0.5.2.1050384`. After the import you will need to add the agent and the component to the `GenAppResource` resource and update the environment properties as mentioned in the tutorial. But we highly recommend following the tutorial to set up the application. 
