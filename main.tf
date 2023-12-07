/**
 * Copyright 2021 Google LLC
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

module "org-policy-cos-os-only" {
  source            = "terraform-google-modules/org-policy/google"
  policy_for        = "organization"
  organization_id   = var.organization_id
  constraint        = "constraints/compute.trustedImageProjects"
  policy_type       = "list"
  allow             = ["projects/cos-cloud"]
  allow_list_length = 1
  exclude_folders   = ["folders/${var.traditional_os_allowed_folder_id}"]
}

module "org-policy-compute-service-isolated" {
  source           = "terraform-google-modules/org-policy/google"
  policy_for       = "organization"
  organization_id  = var.organization_id
  constraint       = "serviceuser.services"
  policy_type      = "list"
  deny             = ["compute.googleapis.com"]
  deny_list_length = 1
  exclude_folders  = ["folders/${var.traditional_os_allowed_folder_id}", "folders/${var.cos_os_allowed_folder_id}"]
}

resource "google_iam_deny_policy" "denypolicy" {
  provider     = google-beta
  parent       = urlencode("cloudresourcemanager.googleapis.com/organizations/${var.organization_id}")
  name         = "block-compute-usage"
  display_name = "block-compute-usage"
  rules {
    deny_rule {
      denied_principals    = ["principalSet://goog/public:all"]
      exception_principals = var.exception_principals
      denied_permissions   = var.denied_permissions
    }
  }
}
