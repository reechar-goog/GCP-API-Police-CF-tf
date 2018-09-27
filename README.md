# GCP-API-Police-CF-tf

This module is a way to deploy a custom Cloud Function that monitors and disables unapproved Google APIs within a GCP Organization. Upon detection that an unapproved API has been enabled, the Cloud Function will actively and automatically disable the API in violation of this policy. This is accomplished by exporting Cloud Audit logs looking for the enablement of APIs under an organization. Those logs are then exported via a Stackdriver Organizational Aggregated Export sink to a Pub/Sub topic, which will then trigger the Cloud Function. This module will provision and connect all the necessary pieces to accomplish this.

## Usage

1. Get a copy of the source for the Cloud Function:
```shell
$ git clone https://github.com/reechar-goog/GCP-API-Police-CF.git
```

2. Make any modifications by following instructions from [README](https://github.com/reechar-goog/GCP-API-Police-CF/blob/master/README.md) and modify [index.js](https://github.com/reechar-goog/GCP-API-Police-CF/blob/master/index.js) 

3. Create terraform file main.tf and fill out with your organizations information

```hcl
module "gcf_api_police" {
  source = "github.com/reechar-goog/GCP-API-Police-CF-tf"
  project_id = "reechar-gcp-api-police"                       #Change to unique project ID
  org_id     = "1234567890"                                   #Change to org id for Organization to be monitored
  billing_id = "ABCDEF-ABCDEF-ABCDEF"                         #Change to your billing account
  gcs_bucket = "reechar-gcf"                                  #Change to unique GCS bucket name
  path_to_gcf_source = "/Users/reechar/git/GCP-API-Police-CF" #Path to gcf source git clone
}

```
4. Initialize terraform and ensure the google provider and this module init with no errors. Run in directory containing main.tf
```shell
$ terraform init
```

5. Plan terraform and double check output and make sure it matches expectations
```shell
$ terraform plan
```
6. Run terraform. Should take ~5 minutes from a clean start. Ensure no errors
```shell
$ terraform apply
```

7. Test and Verify. If you deployed the Cloud Function without modifying the sample code, `translate.googleapis.com` should be blocked. 
```shell
$ gcloud config set project <project_id that you used in step 4>
$ gcloud services list #list currently enabled APIs in project
$ gcloud services enable translate.googleapis.com #try to enable blocked translate API
$ gcloud services enable vision.googleapis.com #enable not blocked API
$ gcloud services list #verify that vision.googleapis is enabled, but translate.googleapis is not
```
## Defense in Depth

As a word of caution, this module is not meant to be a standalone set it and forget it solution. I recommend the practice of [defense in depth](https://en.wikipedia.org/wiki/Defense_in_depth_(computing)) and to have multiple tiers of defense towards addressing this security issue. This solution complements well with a policy scanning tool like [Forseti Security](https://forsetisecurity.org/).


