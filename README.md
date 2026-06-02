# 🇮🇷 Ubuntu Repository Iran

<p align="center">
  <strong>پیشرفته‌ترین ابزار تغییر مخازن اوبونتو به میرورهای ایران با رابط گرافیکی</strong><br>
  <strong>Advanced Ubuntu Mirror Selector with GUI - v2.0</strong>
</p>

<p align="center">
  <img src="https://img.shields.io/badge/version-2.0-blue.svg" alt="Version">
  <img src="https://img.shields.io/badge/Ubuntu-18.04--24.04-orange" alt="Ubuntu">
  <img src="https://img.shields.io/badge/License-MIT-green.svg" alt="License">
  <img src="https://img.shields.io/badge/Shell-Bash-4EAA25?logo=gnu-bash&logoColor=white" alt="Bash">
</p>

---

## ✨ Features | امکانات

| 🇫🇦 فارسی | 🇬🇧 English |
|-----------|------------|
| 🚀 **۱۸+ میرور ایرانی** همراه با نام شهر و| **18+ Iranian Mirrors** with city & provider |
| ⚡ **پیدا کردن سریع‌ترین میرور** (تست سرعت خودکار) | **Fastest Mirror Detection** (auto speed test) |
| 🎨 **نصب خودکار ابزارهای جانبی** (داکر، وب سرور، دیتابیس) | **Auto Install Tools** (Docker, Web Server, DB) |
| 🔧 **تنظیمات پیشرفته** (تغییر نسخه، پشتیبان‌گیری) | **Advanced Settings** (change release, backup) |
| ℹ️ **نمایش اطلاعات سیستم** (کرنل، آپ‌تایم، میرور فعلی) | **System Info** (kernel, uptime, current mirror) |
| 🎨 **منوی رنگی و کاربرپسند** | **Colorful user-friendly menu** |

---

## 🚀 Installation | نصب

### One-line installation (یک خطی):
```bash
bash <(curl -fsSL https://raw.githubusercontent.com/hosseinit1988/Ubuntu-Repository-iran/main/ubuntu-mirror.sh)
```

### Traditional method (روش سنتی):
```bash
git clone https://github.com/hosseinit1988/Ubuntu-Repository-iran.git
cd Ubuntu-Repository-iran
chmod +x ubuntu-mirror.sh
./ubuntu-mirror.sh
```

---

## 📋 Requirements | پیش‌نیازها

- **OS:** Ubuntu 18.04 / 20.04 / 22.04 / 24.04
- **Access:** root or sudo privileges
- **Internet:** Active connection

---

## 🖥️ Menu Preview | پیش‌نمایش منو

```
╔══════════════════════════════════════════════════════════╗
║     Hossein.IT Repository Ubuntu Auto - Version 2.0     ║
║           Advanced Ubuntu Mirror Selector               ║
╚══════════════════════════════════════════════════════════╝

📋 Main Menu | منوی اصلی
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
1) 🇮🇷  Iranian Mirrors | میرورهای ایران
2) 🌍  International Mirrors | میرورهای خارجی
3) ⚡  Find Fastest Mirror | سریع‌ترین میرور
4) 🔧  Advanced Settings | تنظیمات پیشرفته
5) 🎨  Install Extra Tools | نصب ابزارهای جانبی
6) ℹ️   System Information | اطلاعات سیستم
0) 🚪  Exit | خروج
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
```

---

## 📦 After Changing Mirror | بعد از تغییر میرور

```bash
sudo apt update && sudo apt upgrade -y
```

---

## 🗺️ Iranian Mirrors List | لیست میرورهای ایران

| # | Provider | URL | City |
|---|----------|-----|------|
| 1 | ArvanCloud | mirror.arvancloud.ir | تهران |
| 2 | Petiak | archive.ubuntu.petiak.ir | تهران |
| 3 | IUT | repo.iut.ac.ir | اصفهان |
| 4 | Pardisco | mirrors.pardisco.co | تهران |
| 5 | AminiDC | mirror.aminidc.com | تهران |
| 6 | Faraso | mirror.faraso.org | تهران |
| 7 | Sindad | ir.ubuntu.sindad.cloud | تهران |
| 8 | Hostiran | ubuntu.hostiran.ir | تهران |
| 9 | Bardia | ubuntu.bardia.tech | تهران |
| 10 | IranServer | mirror.iranserver.com | تهران |
| 11 | Ubuntu Iran | ir.archive.ubuntu.com | تهران |
| 12 | 0-1 Cloud | mirror.0-1.cloud | تهران |
| 13 | LinuxMirrors | linuxmirrors.ir | تهران |
| 14 | Shatel | ubuntu.shatel.ir | تهران |
| 15 | ByteIran | ubuntu.byteiran.com | تهران |
| 16 | Rasanegar | mirror.rasanegar.com | تهران |
| 17 | Sharif University | mirrors.sharif.ir | تهران |
| 18 | University of Tehran | mirror.ut.ac.ir | تهران |

---

## 🛠 Extra Tools | ابزارهای قابل نصب

| Option | Tool | Description |
|--------|------|-------------|
| 1 | System Update | Update & upgrade all packages |
| 2 | Basic Tools | curl, wget, git, vim, htop, nano |
| 3 | Dev Tools | build-essential, python3, nodejs |
| 4 | Security Tools | ufw, fail2ban, clamav |
| 5 | Docker | Docker & Docker Compose |
| 6 | Monitoring | netdata, glances |
| 7 | Web Server | Nginx/Apache + PHP |
| 8 | Database | MySQL + PostgreSQL |

---

## ⚠️ Important Notes | نکات مهم

> **🇮🇷 فارسی:**
> - این اسکریپت مخصوص کاربران داخل ایران طراحی شده است
> - برای اجرا نیاز به دسترسی **sudo** دارید
> - تست شده روی اوبونتو ۱۸.۰۴، ۲۰.۰۴، ۲۲.۰۴ و ۲۴.۰۴
> - استفاده در خارج از ایران ممکن است کند باشد

> **🇬🇧 English:**
> - Designed for users inside Iran
> - **sudo** access required
> - Tested on Ubuntu 18.04, 20.04, 22.04, 24.04
> - May be slow outside Iran

---

## 🔄 Advanced Features | قابلیت‌های پیشرفته

- ✅ **Auto backup** of `sources.list` before changes
- ✅ **Speed test** with millisecond precision
- ✅ **Sort mirrors** by response time
- ✅ **Change Ubuntu release** (focal, jammy, noble, etc.)
- ✅ **Restore** to previous configuration
- ✅ **Clean APT cache** automatically

---

## 🛠 Developer | توسعه‌دهنده

**Hossein.IT**
- 📌 Open Source Project | پروژه متن‌باز
- 🤝 Contributions welcome | مشارکت شما مایه خوشحالی است
- ⭐ Star the repo if you like it | اگر خوشتون اومد ستاره بدید

---

## 📝 License | لایسنس

```
MIT License - Free to use, modify, and distribute
آزاد برای استفاده، تغییر و توزیع
```

---

<p align="center">
  <b>Made with ❤️ for Iranian Ubuntu users</b><br>
  <b>ساخته شده با عشق برای کاربران اوبونتو در ایران</b>
</p>
