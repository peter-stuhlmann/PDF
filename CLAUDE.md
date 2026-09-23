# CLAUDE.md - GA4 API Setup Merkblatt Generator

This file provides instructions for Claude Code to generate a professional, theme-adaptive DIN A4 PDF cheat sheet/merkblatt for setting up a Google Analytics 4 (GA4) Service Account JSON key and retrieving the GA4 Property ID.

## Overview & Goal
Create a standalone, beautifully styled HTML file (`ga4_setup_merkblatt.html`) optimized for DIN A4 printing and office display. The content must be completely neutral (no placeholder example domains like `example.com` or specific personal project names).

---

## Content & Steps Specification

Claude must include the following precise, step-by-step instructions in the final document:

### Part 1: Google Cloud Project & API Setup
1. **Google Cloud Console öffnen:**
   - Go to [Google Cloud Console](https://console.cloud.google.com/) and log in.
   - Select an existing project in the top header or click **Projekt erstellen**.
2. **Google Analytics Data API aktivieren:**
   - Navigate to **APIs & Dienste** > **Bibliothek** in the left menu.
   - Search for **Google Analytics Data API**.
   - Click the result and click **Aktivieren** (Enable).

### Part 2: Service Account Creation
1. **Zu den Anmeldedaten wechseln:**
   - Go to **APIs & Dienste** > **Anmeldedaten** (Credentials).
   - Click **+ Anmeldedaten erstellen** at the top and select **Dienstkonto** (Service account).
2. **Dienstkonto benennen:**
   - Enter a descriptive name (e.g., `ga4-reporting-bot`). The Service Account ID will auto-populate.
   - Click **Erstellen und fortfahren** (Create and continue). Skip optional permission steps by clicking **Fortfahren** and **Fertig**.

### Part 3: JSON Key Generation
1. **Schlüssel generieren:**
   - In the Service Accounts list, click the newly created account (ending in `...iam.gserviceaccount.com`).
   - Switch to the **Schlüssel** (Keys) tab at the top.
   - Click **Schlüssel hinzufügen** > **Neuen Schlüssel erstellen**.
   - Select **JSON** as the key type and click **Erstellen** to download the file securely.

### Part 4: GA4 Property Access Permission
1. **E-Mail-Adresse kopieren:**
   - Copy the service account's email address (ending in `...@...iam.gserviceaccount.com`).
2. **In GA4 freigeben:**
   - Open [Google Analytics 4](https://analytics.google.com/) and click the **Verwaltung** (Gear icon) at the bottom left.
   - Ensure the correct property is selected in the middle column.
   - Open **Kontozugriffsverwaltung** (Account Access Management).
   - Click **+** > **Nutzer hinzufügen**, paste the service account email, check the **Betrachter** (Viewer) role, and click **Hinzufügen**.

### Part 5: Locating the GA4 Property ID
1. **Property-ID finden:**
   - Open [Google Analytics 4](https://analytics.google.com/) and click **Verwaltung** at the bottom left.
   - Ensure the correct property is active in the middle column.
   - Click **Property-Einstellungen** (Property Settings).
   - Copy the numeric **Property-ID** (e.g., `123456789`) from the top.

---

## HTML/CSS Design Template (DIN A4 Optimization)

When generating or updating `ga4_setup_merkblatt.html`, Claude must use the following layout structure to ensure clean page breaks and professional styling:

```html
<!DOCTYPE html>
<html lang="de">
<head>
    <meta charset="UTF-8">
    <title>Google Analytics 4 API Setup-Merkblatt</title>
    <style>
        @page { margin: 0; size: A4 portrait; }
        *, *::before, *::after { box-sizing: border-box; }
        html, body { margin: 0; padding: 0; background-color: #ffffff; }
        @media (prefers-color-scheme: dark) {
            html { background-color: #1f1f1f; }
        }
        body { 
            padding: 12px 0;
            margin: 0 auto;
            max-width: 900px;
            font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, Helvetica, Arial, sans-serif;
            color: #1e293b;
        }
        .page {
            height: 297mm;
            width: 210mm;
            margin: 0 auto;
            padding: 12mm 14mm 10mm 14mm;
            background-color: #ffffff;
            border: 1px solid rgba(0, 0, 0, 0.12);
            display: flex;
            flex-direction: column;
            justify-content: space-between;
        }
        @media print {
            body { padding: 0; background: none; }
            .page { margin: 0; border: none; box-shadow: none; }
        }
        .header-banner {
            background: linear-gradient(135deg, #0f172a 0%, #1e3a8a 100%);
            color: #ffffff;
            padding: 14px 18px;
            border-radius: 6px;
            margin-bottom: 10px;
        }
        .header-banner h1 { margin: 0 0 4px 0; font-size: 18pt; font-weight: 700; }
        .header-banner p { margin: 0; font-size: 9.5pt; color: #93c5fd; }
        
        .grid-container {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 10px;
            margin-bottom: 10px;
        }
        .card {
            background: #f8fafc;
            border: 1px solid #e2e8f0;
            border-left: 4px solid #3b82f6;
            border-radius: 6px;
            padding: 8px 10px;
        }
        .card.accent { border-left-color: #10b981; }
        .card h3 {
            margin: 0 0 4px 0;
            font-size: 10pt;
            color: #0f172a;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        .badge {
            background: #e2e8f0;
            color: #334155;
            font-size: 7pt;
            padding: 1px 5px;
            border-radius: 4px;
        }
        ol { margin: 0; padding-left: 14px; font-size: 8.5pt; line-height: 1.3; }
        li { margin-bottom: 3px; }
        
        .full-width-card {
            background: #f8fafc;
            border: 1px solid #e2e8f0;
            border-left: 4px solid #f59e0b;
            border-radius: 6px;
            padding: 8px 12px;
            margin-bottom: 10px;
        }
        .full-width-card h3 { margin: 0 0 4px 0; font-size: 10pt; color: #0f172a; }
        
        .warning-box {
            background: #fef2f2;
            border: 1px solid #fecaca;
            border-left: 4px solid #ef4444;
            border-radius: 6px;
            padding: 6px 10px;
            font-size: 8pt;
            color: #991b1b;
        }
        .page-footer {
            display: flex;
            justify-content: space-between;
            font-size: 8pt;
            color: #64748b;
            border-top: 1px solid #e2e8f0;
            padding-top: 2mm;
        }
    </style>
</head>
<body>
    <div class="page">
        <!-- Content sections go here -->
    </div>
</body>
</html>
```

## Execution Instructions for Claude
When requested to build or update the cheat sheet, Claude will output a fully populated, standalone HTML file using the layout and exact step-by-step instructions specified above without asking for additional context.