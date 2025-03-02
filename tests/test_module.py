from textwrap import dedent

from pytest_infrahouse import terraform_apply

from tests.conftest import TERRAFORM_ROOT_DIR

from os import path as osp


def test_module(keep_after, test_role_arn, aws_region):
    terraform_module_dir = osp.join(TERRAFORM_ROOT_DIR, "guardduty-configuration")
    with open(osp.join(terraform_module_dir, "terraform.tfvars"), "w") as fp:
        fp.write(
            dedent(
                f"""
                region        = "{aws_region}"
                """
            )
        )
        if test_role_arn:
            fp.write(
                dedent(
                    f"""
                    role_arn      = "{test_role_arn}"
                    """
                )
            )

    with terraform_apply(
        terraform_module_dir,
        destroy_after=not keep_after,
        json_output=True,
    ) as tf_output:
        pass
