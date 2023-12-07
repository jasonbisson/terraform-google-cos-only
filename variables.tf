/**
 * Copyright 2018 Google LLC
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

variable "policy_for" {
  description = "Resource hierarchy node to apply the policy to: can be one of `organization`, `folder`, or `project`."
  type        = string
  default     = null
}
variable "organization_id" {
  description = "The organization id for putting the policy"
  type        = string
  default     = null
}

variable "traditional_os_allowed_folder_id" {
  description = "The folder id is for projects where traditional operating systems can be deployed"
  type        = string
}

variable "cos_os_allowed_folder_id" {
  description = "The folder id is for projects where only the locked down Container Optimized operating system (aka GKE) can be deployed"
  type        = string
}

variable "project_id" {
  description = "The project id for putting the policy"
  type        = string
  default     = null
}

variable "exception_principals" {
  description = "Service Agents where compute instances will not be denied"
  type        = list(string)
}

variable "denied_permissions" {
  description = "List of permissions for the deny policy"
  type        = list(string)
}

variable "enforce" {
  description = "If boolean constraint, whether the policy is enforced at the root; if list constraint, whether to deny all (true) or allow all"
  type        = bool
  default     = null
}

variable "allow" {
  description = "(Only for list constraints) List of values which should be allowed"
  type        = list(string)
  default     = [""]
}

variable "deny" {
  description = "(Only for list constraints) List of values which should be denied"
  type        = list(string)
  default     = [""]
}

variable "exclude_folders" {
  description = "Set of folders to exclude from the policy"
  type        = set(string)
  default     = []
}

variable "exclude_projects" {
  description = "Set of projects to exclude from the policy"
  type        = set(string)
  default     = []
}

variable "constraint" {
  description = "The constraint to be applied"
  type        = string
  default     = null
}

variable "policy_type" {
  description = "The constraint type to work with (either 'boolean' or 'list')"
  type        = string
  default     = "list"
}

variable "allow_list_length" {
  description = "The number of elements in the allow list"
  type        = number
  default     = 0
}

variable "deny_list_length" {
  description = "The number of elements in the deny list"
  type        = number
  default     = 0
}