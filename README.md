# Understanding Terraform experiment mode

As of Terraform v1.3.0 onwards, the `optional` syntax is no longer experimental;
It has become official.

Previously, i.e., Terraform < 1.3.0, to use this syntax, we would need to **enable the experiment mode**.

```hcl
terraform {
  experiments = [module_variable_optional_attrs]
}
```

However, there is no backwards compatibility built-in;
> See https://github.com/hashicorp/terraform/issues/31355#issuecomment-1172457816

Meaning, if you "upgrade" your Terraform to >= 1.3.0, you also need to **remove** this experiment mode.

Otherwise, Terraform **exits non-zero**, instead of a warning.

```
╷
│ Error: Experiment has concluded
│ 
│   on providers.tf line 3, in terraform:
│    3:     module_variable_optional_attrs
│ 
│ Experiment "module_variable_optional_attrs" is no longer available. The final feature corresponding to this experiment differs from the experimental form and is available in the Terraform language from Terraform v1.3.0 onwards.
```

In this repo, I recreated the situations through a CircleCI pipeline:

| Terraform version | Experiment declared? | Result |
| --- | --- | --- |
| 1.2.7 | Yes | SUCCESS |
| 1.2.7 | No | Error as expected; Need to enable experiment |
| 1.3.10 | Yes | Error; No longer need to enable experiment |
| 1.3.10 | No | SUCCESS |

You can `diff` between the `pre_1.3` and `post_1.3` folders for inspection.

```shell
diff pre_1.3 post_1.3
```

Here is the matrix build on CircleCI:
https://app.circleci.com/pipelines/github/cr-kelvintaywl/investigate-terraform-experiment/
