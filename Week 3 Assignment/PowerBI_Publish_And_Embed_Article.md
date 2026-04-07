# A Practical Guide to Publishing and Embedding Power BI Reports with IFrames

_A step-by-step beginner-friendly walkthrough for publishing a Power BI report and embedding it on a website portal._

---

Power BI is one of those tools that feels simple at first, then becomes very powerful as soon as you start sharing your work with other people. Building the report is one part of the process. Making it accessible and useful to others is the real final step.

In this guide, I will walk through how to:

- Create a Power BI workspace
- Upload and publish your `.pbix` report
- Generate an embed link (iframe)
- Add the report to a public to make it accessible by others

---

## Why publishing matters in Power BI

Creating visuals in Power BI Desktop is useful, but reports become more impactful when they can be accessed by others. Publishing gives your report a home in Power BI Service, where it can be viewed, shared, and embedded into a website.

If you only keep reports in Desktop:

- Access is limited to the local machine
- Collaboration is hard
- Stakeholders cannot view updates easily
- There is no web link for presentation or portfolio use

Publishing solves all that by moving your report to the cloud and giving you options to share it safely.

---

## What you need before starting

Before you begin, make sure these are ready:

1. A Power BI account (work or school account, depending on your setup)
2. A finished `.pbix` file that has the dashboards and reports
3. Access to Power BI Service at [https://app.powerbi.com](https://app.powerbi.com)
4. A GitHub account (for hosting the website and uploading the `.pbix` file)
5. Your report iframe code gotten from Power BI Service site

---

## Step 1: Creating your workspace

In Power BI Service, workspaces are like project rooms where reports and dashboards live.

### How to do it

1. Open [https://app.powerbi.com](https://app.powerbi.com)
2. On the left sidebar, click **Workspaces**
3. Click **New workspace** and give it a preferred name and description of your liking

![workspace creation](https://dev-to-uploads.s3.amazonaws.com/uploads/articles/mmxcgkvu3ohykywramb1.webp)

_This step matters because it keeps your work, reports and content organized_

Tip: Keep the workspace name professional and clear, for example `North America Region - Sales Reports`.

---

## Step 2: Uploading and publishing your reports

Now you need to place your `.pbix` file in the workspace so it can be opened in the browser. We are already assuming you have the report and dashboard report ready as a `.pbix` file

### Option A: Publish directly from Power BI Desktop (recommended & faster)

1. Open your report in Power BI Desktop
2. Click **Publish** from the menu options in top bar

![publishing workspace 1](https://dev-to-uploads.s3.amazonaws.com/uploads/articles/cpq5qxukkj9okloc4m01.jpg)

3. Choose the workspace name you created above
4. Wait for the success confirmation

### Option B: Upload from Power BI Service

1. Open the target workspace in Power BI Service
2. Click **Import** or **New > Report or Workbook > From this Computer**

![publishing workspace 2](https://dev-to-uploads.s3.amazonaws.com/uploads/articles/77g32nxhmyhvavjthuq0.jpg)

3. Select your Reports/Dashboard `.pbix` file
4. Wait for import completion

### What to check after upload

- The report appears under the workspace content
- The dataset/model is visible
- Opening the report shows all visuals correctly

Your report should display like this:

![published report](https://dev-to-uploads.s3.amazonaws.com/uploads/articles/085t90lk2fa9d9cdiz3t.jpg)

---

## Step 3: Generating the embed code (iframe)

Once your report is in Power BI Service, you can generate code that lets the report appear inside a web page.

### How to generate iframe embed code

1. Open the report in Power BI Service
2. Click **File** or **Share** (depends on UI version)
3. Look for **Embed report** or **Publish to web**
4. Choose the appropriate embed option
5. Copy the generated `<iframe ... ></iframe>` code

If prompted, confirm that you understand visibility settings.

![embedding report](https://dev-to-uploads.s3.amazonaws.com/uploads/articles/fiih8ex1d6ufrw3ad8it.webp)

### Important note on privacy

There are different embedding methods in Power BI:

- **Publish to web**: public access, good for portfolio/demos, not for sensitive data
- **Secure embedding/organization methods**: for internal/private use

Always confirm data is safe to make public before using it.

---

Now that you have the iframe lik, you can share it with your developer or add it yourself to the index.html file of your public site for others to view.

You can use a clean layout with a heading, short description, and responsive iframe container.

## Common issues and how to fix them quickly

### 1) Report not showing on website

Possible causes:

- Wrong iframe copied
- Embed permission not set

Fix:

- Re-copy iframe from Power BI Service
- Check on the permissions applied and confirm if accurate
- Refresh with hard reload

### 2) Blank area where report should appear

Possible causes:

- Browser blocked mixed content
- Iframe width/height too small

Fix:

- Ensure `https` is used
- Set iframe width to `100%` and enough height (700px+)

### 3) Wrong workspace or missing report

Possible causes:

- Uploaded to a different workspace
- Report upload failed silently

Fix:

- Confirm workspace name
- Re-upload the `.pbix` file and wait for completion

_That's all you need to publish and embed your POwer BI Dashboards and Reports online, easy as 123_
