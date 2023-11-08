

resource "github_repository" "test-terraform-repo" {
  name = "test-terraform-repo"
  description = "This is repo for terraform testing"
  visibility = "public"
  auto_init = true
}
resource "github_repository" "test2-terraform-repo" {
  name = "test2-terraform-repo"
  description = "This is repo for terraform testing"
  visibility = "public"
  auto_init = true
}