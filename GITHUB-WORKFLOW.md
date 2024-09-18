# GitHub Workflow with Jira Integration

This document outlines the GitHub workflow for branching, committing, and pushing changes, ensuring that Jira recognizes the branch and any changes related to the ticket.

## Prerequisites

- You should have a Jira account set up with the FlavorShare Project. You can contact an admin if you aren't part of the Jira project.
- A ticket should exist with the current Feature, Enhancement, or Bug.

## Workflow Overview

1. **Create a Branch Based on Jira Ticket ID**
2. **Make Changes Locally**
3. **Commit Changes with Reference to the Jira Ticket**
4. **Push the Branch to GitHub**
5. **Open a Pull Request**
6. **Link the Pull Request to the Jira Ticket**
7. **Merge the Pull Request and Close the Jira Ticket**

---

## 1. Create a Branch Based on Jira Ticket ID

When you begin work on a Jira ticket, create a new branch that includes the ticket ID from Jira. This ensures Jira can track the branch.

### Example

If the Jira ticket is `FS-123`, the branch should be named using the ticket ID:

```bash
git checkout -b feature/FS-123
```

- **Naming convention**: Use a prefix that describes the type of work (`feature`, `enhancement`, or `bug`, etc.), followed by the ticket ID, and a short description of the task.

---

## 2. Make Changes Locally

Work on your changes as usual in this branch. Add or modify code to implement the feature or fix the bug assigned in the Jira ticket.

---

## 3. Commit Changes with Reference to the Jira Ticket

When committing changes, include the Jira ticket ID in your commit message so Jira can track the commits related to the ticket.

### Example

```bash
git add .
git commit -m "PROJ-123: Implement new feature for user login"
```

- Make sure the commit message follows this pattern: `TICKET-ID: Ticket title (Description of change)`.

---

## 4. Push the Branch to GitHub

Push your branch to GitHub for review.

```bash
git push origin feature/PROJ-123-description
```

This allows the branch to be visible on GitHub and linked to the Jira ticket.

---

## 5. Open a Pull Request

Once your changes are ready, create a Pull Request from the branch to the "dev" branch. Jira will automatically link this Pull Request to the ticket based on the branch name.

### Example

- Pull Request title: `PROJ-123: Implement new feature for user login`
- Pull Request description: Include a brief summary of the changes and the Jira ticket reference.

---

## 6. Merge the Pull Request and Close the Jira Ticket

After review, merge the Pull Request into the "dev" branch. Ensure that Jira transitions the ticket to 'Done' or the appropriate status.

```bash
git checkout main
git pull origin main
git merge feature/PROJ-123-description
git push origin dev
```

Once merged, Jira will recognize the changes and automatically update the ticket’s status.

---

## Summary

1. **Branch**: Create a branch using `TICKET-ID-description`.
2. **Commit**: Use `TICKET-ID` in every commit message.
3. **Push**: Push your branch and open a Pull Request referencing the ticket.
4. **Link**: Ensure Jira links the branch, commits, and Pull Request to the ticket.
5. **Merge**: Merge the PR to close the Jira ticket.

---

This process ensures a smooth workflow between GitHub and Jira, allowing better work traceability across both platforms.
