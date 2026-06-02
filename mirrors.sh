#!/bin/bash

#=====================================
# Hossein.IT Repository Ubuntu Auto
# Advanced Ubuntu Mirror Selector v2.0
#=====================================

# رنگ‌ها برای ترمینال
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
WHITE='\033[1;37m'
NC='\033[0m' # No Color
BOLD='\033[1m'

# تنظیمات اولیه
set -e
UBUNTU_CODENAME="jammy"  # Ubuntu 22.04
SCRIPT_VERSION="2.0"

# تابع نمایش header
show_header() {
    clear
    echo -e "${CYAN}${BOLD}"
    echo "╔══════════════════════════════════════════════════════════╗"
    echo "║     Hossein.IT Repository Ubuntu Auto - Version $SCRIPT_VERSION     ║"
    echo "║           Advanced Ubuntu Mirror Selector               ║"
    echo "╚══════════════════════════════════════════════════════════╝"
    echo -e "${NC}"
}

# تابع نمایش progress bar
show_progress() {
    local pid=$1
    local delay=0.1
    local spinstr='|/-\'
    echo -ne "${YELLOW}⏳ در حال بررسی میرورها... ${NC}"
    while [ "$(ps a | awk '{print $1}' | grep $pid)" ]; do
        local temp=${spinstr#?}
        printf " [%c]  " "$spinstr"
        local spinstr=$temp${spinstr%"$temp"}
        sleep $delay
        printf "\b\b\b\b\b\b"
    done
    echo -e " ${GREEN}✓${NC}"
}

# تابع تست میرور با timeout بهتر
test_mirror() {
    local mirror=$1
    local start_time=$(date +%s%N)
    
    if curl -s --max-time 3 --head "$mirror" 2>/dev/null | grep -q "200 OK"; then
        local end_time=$(date +%s%N)
        local duration=$((($end_time - $start_time) / 1000000))
        echo "✅|$mirror|${duration}ms"
        return 0
    else
        echo "❌|$mirror|0"
        return 1
    fi
}

# لیست کامل میرورها با دسته‌بندی
declare -A MIRROR_CATEGORIES

MIRRORS_IRAN=(
    "http://mirror.arvancloud.ir/ubuntu|ArvanCloud - تهران"
    "https://archive.ubuntu.petiak.ir/ubuntu/|Petiak - تهران"
    "http://repo.iut.ac.ir/repo/Ubuntu/|IUT - اصفهان"
    "https://mirrors.pardisco.co/ubuntu/|Pardisco - تهران"
    "http://mirror.aminidc.com/ubuntu/|AminiDC - تهران"
    "http://mirror.faraso.org/ubuntu/|Faraso - تهران"
    "https://ir.ubuntu.sindad.cloud/ubuntu/|Sindad - تهران"
    "https://ubuntu.hostiran.ir/ubuntuarchive/|Hostiran - تهران"
    "https://ubuntu.bardia.tech/|Bardia - تهران"
    "https://mirror.iranserver.com/ubuntu/|IranServer - تهران"
    "https://ir.archive.ubuntu.com/ubuntu/|Ubuntu Iran - تهران"
    "https://mirror.0-1.cloud/ubuntu/|0-1 Cloud - تهران"
    "http://linuxmirrors.ir/pub/ubuntu/|LinuxMirrors - تهران"
    "https://ubuntu.shatel.ir/ubuntu/|Shatel - تهران"
    "http://ubuntu.byteiran.com/ubuntu/|ByteIran - تهران"
    "https://mirror.rasanegar.com/ubuntu/|Rasanegar - تهران"
    "http://mirrors.sharif.ir/ubuntu/|دانشگاه شریف - تهران"
    "http://mirror.ut.ac.ir/ubuntu/|دانشگاه تهران"
)

MIRRORS_WORLD=(
    "http://archive.ubuntu.com/ubuntu/|Ubuntu Official - USA"
    "http://mirrors.kernel.org/ubuntu/|Kernel.org - USA"
    "https://mirror.init7.net/ubuntu/|Init7 - Switzerland"
    "http://ftp.rz.uni-wuerzburg.de/ubuntu/|University Wuerzburg - Germany"
    "http://mirror.23m.com/ubuntu/|23M - USA"
)

# اضافه کردن گزینه‌های جدید
EXTRA_FEATURES=(
    "1|🚀 Update System & Upgrade Packages"
    "2|📦 Install Common Tools (curl, git, vim, htop)"
    "3|🔧 Install Development Tools (build-essential, python3, nodejs)"
    "4|🛡️ Install Security Tools (ufw, fail2ban, clamav)"
    "5|🐳 Install Docker & Docker Compose"
    "6|📊 Install Monitoring Tools (netdata, glances)"
    "7|🌐 Install Web Server (Nginx/Apache + PHP)"
    "8|💾 Install Database (MySQL/PostgreSQL)"
)

# تابع نمایش منوی اصلی
show_main_menu() {
    show_header
    echo -e "${GREEN}${BOLD}📋 منوی اصلی${NC}"
    echo -e "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo -e "${WHITE}1) 🇮🇷  انتخاب از میرورهای ایران${NC}"
    echo -e "${WHITE}2) 🌍  انتخاب از میرورهای خارجی${NC}"
    echo -e "${WHITE}3) ⚡  پیدا کردن سریع‌ترین میرور (Auto Detect)${NC}"
    echo -e "${WHITE}4) 🔧  تنظیمات پیشرفته${NC}"
    echo -e "${WHITE}5) 🎨  نصب ابزارهای جانبی${NC}"
    echo -e "${WHITE}6) ℹ️   اطلاعات سیستم${NC}"
    echo -e "${WHITE}0) 🚪  خروج${NC}"
    echo -e "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo -ne "${YELLOW}🔹 انتخاب کنید [0-6]: ${NC}"
}

# تابع نمایش میرورها
show_mirrors() {
    local category="$1"
    shift
    local mirrors=("$@")
    
    clear
    show_header
    echo -e "${GREEN}${BOLD}📡 میرورهای $category${NC}"
    echo -e "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    
    for i in "${!mirrors[@]}"; do
        IFS='|' read -r url name <<< "${mirrors[$i]}"
        printf "${WHITE}%2d) ${CYAN}%-30s ${WHITE}- ${YELLOW}%s${NC}\n" $((i+1)) "$name" "$url"
    done
    
    echo -e "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo -e "${WHITE}0) 🔙  بازگشت به منوی اصلی${NC}"
    echo -ne "${YELLOW}🔹 شماره میرور مورد نظر را انتخاب کنید: ${NC}"
}

# تابع اعمال میرور انتخابی
apply_mirror() {
    local mirror_url=$1
    local mirror_name=$2
    
    show_header
    echo -e "${YELLOW}⏳ در حال اعمال میرور $mirror_name ...${NC}"
    
    sudo tee /etc/apt/sources.list > /dev/null <<EOF
deb ${mirror_url} ${UBUNTU_CODENAME} main restricted universe multiverse
deb ${mirror_url} ${UBUNTU_CODENAME}-updates main restricted universe multiverse
deb ${mirror_url} ${UBUNTU_CODENAME}-backports main restricted universe multiverse
deb ${mirror_url} ${UBUNTU_CODENAME}-security main restricted universe multiverse
EOF
    
    echo -e "${GREEN}✅ میرور با موفقیت اعمال شد!${NC}"
    echo -e "${WHITE}میرور انتخاب شده: ${CYAN}$mirror_name${NC}"
    echo -e "${WHITE}آدرس: ${YELLOW}$mirror_url${NC}"
    echo ""
    echo -e "${GREEN}👇 برای اعمال تغییرات، دستور زیر را اجرا کنید:${NC}"
    echo -e "${CYAN}sudo apt update && sudo apt upgrade -y${NC}"
    echo ""
    
    read -p "آیا می‌خواهید همین الان apt update را اجرا کنید؟ (y/n): " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        echo -e "${YELLOW}⏳ در حال بروزرسانی ...${NC}"
        sudo apt update
        echo -e "${GREEN}✅ بروزرسانی کامل شد!${NC}"
    fi
}

# تابع پیدا کردن سریع‌ترین میرور
find_fastest_mirror() {
    show_header
    echo -e "${YELLOW}${BOLD}⚡ در حال تست سرعت میرورها ...${NC}"
    echo -e "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    
    local all_mirrors=()
    for m in "${MIRRORS_IRAN[@]}"; do
        all_mirrors+=("$m")
    done
    for m in "${MIRRORS_WORLD[@]}"; do
        all_mirrors+=("$m")
    done
    
    local results=()
    local counter=1
    local total=${#all_mirrors[@]}
    
    for mirror in "${all_mirrors[@]}"; do
        IFS='|' read -r url name <<< "$mirror"
        echo -ne "${WHITE}[$counter/$total]${NC} تست ${CYAN}$name${NC} ... "
        
        local start_time=$(date +%s%N)
        if curl -s --max-time 2 --head "$url" > /dev/null 2>&1; then
            local end_time=$(date +%s%N)
            local duration=$((($end_time - $start_time) / 1000000))
            echo -e "${GREEN}✓ ${duration}ms${NC}"
            results+=("$duration|$url|$name")
        else
            echo -e "${RED}✗ غیرفعال${NC}"
        fi
        ((counter++))
    done
    
    if [ ${#results[@]} -eq 0 ]; then
        echo -e "${RED}❌ هیچ میرور فعالی یافت نشد!${NC}"
        return 1
    fi
    
    # مرتب‌سازی بر اساس سرعت
    IFS=$'\n' sorted=($(sort -n <<<"${results[*]}"))
    unset IFS
    
    echo -e "\n${GREEN}${BOLD}🏆 سریع‌ترین میرورها:${NC}"
    echo -e "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    
    local count=0
    for result in "${sorted[@]}"; do
        IFS='|' read -r duration url name <<< "$result"
        if [ $count -lt 5 ]; then
            printf "${GREEN}%2d)${NC} ${WHITE}%-35s ${YELLOW}%4dms${NC}\n" $((count+1)) "$name" "$duration"
            if [ $count -eq 0 ]; then
                BEST_URL="$url"
                BEST_NAME="$name"
            fi
        fi
        ((count++))
    done
    
    echo -e "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo -ne "${YELLOW}آیا می‌خواهید سریع‌ترین میرور (${BEST_NAME}) را اعمال کنید؟ (y/n): ${NC}"
    read -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        apply_mirror "$BEST_URL" "$BEST_NAME"
    fi
}

# تابع نصب ابزارهای جانبی
install_extra_tools() {
    show_header
    echo -e "${GREEN}${BOLD}🎨 نصب ابزارهای جانبی${NC}"
    echo -e "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    
    for tool in "${EXTRA_FEATURES[@]}"; do
        IFS='|' read -r num desc <<< "$tool"
        echo -e "${WHITE}$num) ${CYAN}$desc${NC}"
    done
    echo -e "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo -e "${WHITE}0) 🔙 بازگشت${NC}"
    echo -ne "${YELLOW}🔹 انتخاب کنید: ${NC}"
    
    read -r choice
    case $choice in
        1)
            echo -e "${YELLOW}⏳ در حال بروزرسانی سیستم...${NC}"
            sudo apt update && sudo apt upgrade -y
            ;;
        2)
            echo -e "${YELLOW}⏳ نصب ابزارهای پایه...${NC}"
            sudo apt install -y curl wget git vim htop nano net-tools
            ;;
        3)
            echo -e "${YELLOW}⏳ نصب ابزارهای توسعه...${NC}"
            sudo apt install -y build-essential python3 python3-pip nodejs npm
            ;;
        4)
            echo -e "${YELLOW}⏳ نصب ابزارهای امنیتی...${NC}"
            sudo apt install -y ufw fail2ban clamav
            sudo ufw enable
            ;;
        5)
            echo -e "${YELLOW}⏳ نصب داکر...${NC}"
            curl -fsSL https://get.docker.com | sh
            sudo usermod -aG docker $USER
            ;;
        6)
            echo -e "${YELLOW}⏳ نصب ابزارهای مانیتورینگ...${NC}"
            sudo apt install -y netdata glances
            ;;
        7)
            echo -e "${YELLOW}⏳ نصب وب سرور...${NC}"
            sudo apt install -y nginx php-fpm php-mysql
            ;;
        8)
            echo -e "${YELLOW}⏳ نصب دیتابیس...${NC}"
            sudo apt install -y mysql-server postgresql
            ;;
        0)
            return
            ;;
        *)
            echo -e "${RED}❌ گزینه نامعتبر!${NC}"
            sleep 1
            ;;
    esac
    
    echo -e "${GREEN}✅ نصب با موفقیت انجام شد!${NC}"
    read -p "Enter را فشار دهید تا ادامه دهید..."
}

# تابع اطلاعات سیستم
show_system_info() {
    show_header
    echo -e "${GREEN}${BOLD}ℹ️  اطلاعات سیستم${NC}"
    echo -e "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    
    echo -e "${WHITE}🖥️  میزبان:${NC}     ${CYAN}$(hostname)${NC}"
    echo -e "${WHITE}🐧 کرنل:${NC}        ${CYAN}$(uname -r)${NC}"
    echo -e "${WHITE}📀 معماری:${NC}      ${CYAN}$(uname -m)${NC}"
    echo -e "${WHITE}🔄 آپ تایم:${NC}     ${CYAN}$(uptime -p)${NC}"
    echo -e "${WHITE}👤 کاربر:${NC}       ${CYAN}$USER${NC}"
    echo -e "${WHITE}📅 تاریخ:${NC}       ${CYAN}$(date '+%Y-%m-%d %H:%M:%S')${NC}"
    
    if [ -f /etc/apt/sources.list ]; then
        echo -e "\n${WHITE}🔗 میرور فعلی:${NC}"
        grep "^deb" /etc/apt/sources.list | head -1 | sed 's/deb //' | sed 's/ .*//' | while read line; do
            echo -e "   ${CYAN}$line${NC}"
        done
    fi
    
    echo -e "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    read -p "Enter را فشار دهید تا ادامه دهید..."
}

# تابع تنظیمات پیشرفته
advanced_settings() {
    show_header
    echo -e "${GREEN}${BOLD}🔧 تنظیمات پیشرفته${NC}"
    echo -e "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo -e "${WHITE}1) تغییر نسخه اوبونتو (فعلی: $UBUNTU_CODENAME)${NC}"
    echo -e "${WHITE}2) پشتیبان‌گیری از sources.list${NC}"
    echo -e "${WHITE}3) بازگردانی به میرور پیش‌فرض${NC}"
    echo -e "${WHITE}4) پاکسازی کش apt${NC}"
    echo -e "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo -e "${WHITE}0) 🔙 بازگشت${NC}"
    echo -ne "${YELLOW}🔹 انتخاب کنید: ${NC}"
    
    read -r choice
    case $choice in
        1)
            echo -ne "${YELLOW}کدنسخه جدید را وارد کنید (مثال: focal, jammy, noble): ${NC}"
            read -r new_codename
            if [ -n "$new_codename" ]; then
                UBUNTU_CODENAME="$new_codename"
                echo -e "${GREEN}✅ نسخه به $UBUNTU_CODENAME تغییر کرد${NC}"
            fi
            ;;
        2)
            sudo cp /etc/apt/sources.list /etc/apt/sources.list.backup.$(date +%Y%m%d_%H%M%S)
            echo -e "${GREEN}✅ پشتیبان‌گیری انجام شد${NC}"
            ;;
        3)
            sudo cp /etc/apt/sources.list.backup.* /etc/apt/sources.list 2>/dev/null || echo -e "${RED}❌ پشتیبانی یافت نشد${NC}"
            echo -e "${GREEN}✅ بازگردانی انجام شد${NC}"
            ;;
        4)
            sudo apt clean && sudo apt autoclean
            echo -e "${GREEN}✅ کش پاک شد${NC}"
            ;;
    esac
    sleep 2
}

# حلقه اصلی برنامه
while true; do
    show_main_menu
    read -r main_choice
    
    case $main_choice in
        1)
            while true; do
                show_mirrors "ایران" "${MIRRORS_IRAN[@]}"
                read -r mirror_choice
                if [ "$mirror_choice" == "0" ]; then
                    break
                elif [ "$mirror_choice" -ge 1 ] && [ "$mirror_choice" -le ${#MIRRORS_IRAN[@]} ]; then
                    idx=$((mirror_choice-1))
                    IFS='|' read -r url name <<< "${MIRRORS_IRAN[$idx]}"
                    apply_mirror "$url" "$name"
                    break
                else
                    echo -e "${RED}❌ گزینه نامعتبر!${NC}"
                    sleep 1
                fi
            done
            ;;
        2)
            while true; do
                show_mirrors "خارجی" "${MIRRORS_WORLD[@]}"
                read -r mirror_choice
                if [ "$mirror_choice" == "0" ]; then
                    break
                elif [ "$mirror_choice" -ge 1 ] && [ "$mirror_choice" -le ${#MIRRORS_WORLD[@]} ]; then
                    idx=$((mirror_choice-1))
                    IFS='|' read -r url name <<< "${MIRRORS_WORLD[$idx]}"
                    apply_mirror "$url" "$name"
                    break
                else
                    echo -e "${RED}❌ گزینه نامعتبر!${NC}"
                    sleep 1
                fi
            done
            ;;
        3)
            find_fastest_mirror
            read -p "Enter را فشار دهید تا ادامه دهید..."
            ;;
        4)
            advanced_settings
            ;;
        5)
            install_extra_tools
            ;;
        6)
            show_system_info
            ;;
        0)
            echo -e "${GREEN}👋 خدانگهدار!${NC}"
            exit 0
            ;;
        *)
            echo -e "${RED}❌ گزینه نامعتبر!${NC}"
            sleep 1
            ;;
    esac
done
