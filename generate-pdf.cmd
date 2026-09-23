@echo off
rem Doppelklick-Starter fuer generate-pdf.ps1 (Parameter werden durchgereicht)
powershell -NoProfile -ExecutionPolicy Bypass -File "%~dp0generate-pdf.ps1" %*
