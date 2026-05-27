---
agent: agent
description: 'Update documentation and changelog for this Terraform module'
---
You are an expert Technical Writer and DevOps Engineer.
Your task is to update the documentation and changelog for this Terraform module.

**Note**: This project uses `terraform-docs` to automatically generate the Inputs, Outputs, and Resources sections in README.md. Do not manually edit those tables.

1.  **Analyze Changes**:
    *   Read all `*.tf` files to understand the resources and the module's purpose.
    *   Review recent changes in the codebase to identify what has been added, changed, or fixed.

2.  **Update CHANGELOG.md**:
    *   Follow the "Keep a Changelog" format.
    *   **Release Logic**: The release pipeline checks for the `[Unreleased]` section.
        *   **To Release**: Rename `## [Unreleased]` to `## [Version]() (YYYY-MM-DD)` (e.g., `## [1.0.0]() (2025-07-10)`). This triggers the release workflow.
        *   **To Stage Changes**: Add entries under `## [Unreleased]`. If it doesn't exist, create it at the top.
    *   Categorize changes into: `Features`, `Bug fixes`, `Refactoring`, `Documentation`.
    *   Use `*` for bullet points.
    *   Be concise but descriptive.

3.  **Update README.md Narrative**:
    *   **Description**: Ensure the introduction accurately explains *what* the module does and *why* to use it.
    *   **Usage**: Update the "Usage" section with a realistic, copy-pasteable example.
    *   **Examples**: Reference any new examples found in the `examples/` directory.

4.  **Review**: Ensure the tone is professional and concise.

Do not duplicate the work of `terraform-docs`.
