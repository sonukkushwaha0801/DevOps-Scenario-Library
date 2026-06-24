# Partial Apply Simulation

## Step 1 — Initialize Terraform

```bash
terraform init
```

---

## Step 2 — Start Apply

```bash
terraform apply
```

Expected:
Terraform creates:

* VPC
* Subnet
* Security Group

Expected failure:
EC2 creation fails due to invalid AMI.

---

## Step 3 — Observe Failure

Expected error:

```text
Error: collecting instance settings: InvalidAMIID.NotFound
```

Result:
Partial infrastructure exists.
