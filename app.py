# opbloody999/tawk-to/tawk-to-d2f4b5e1baebf4730587fb5b6e574f07b47967ce/app.py

import streamlit as st
import os, pickle, time
from selenium import webdriver
from selenium.webdriver.common.by import By
from selenium.webdriver.chrome.options import Options
from selenium.webdriver.chrome.service import Service
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.support import expected_conditions as EC
from webdriver_manager.chrome import ChromeDriverManager

COOKIES = "tawk_cookies.pkl"

st.set_page_config(page_title="Tawk.to Editor", layout="centered")
st.title("🛠️ Tawk.to Channel Description Editor")

# In app.py

@st.cache_resource
def start_browser():
    options = Options()
    options.add_argument("--headless")
    options.add_argument("--no-sandbox")
    options.add_argument("--disable-dev-shm-usage")
    # Change this line to point to chromium-browser
    options.binary_location = "/usr/bin/chromium-browser" 
    
    service = Service(ChromeDriverManager().install())
    
    return webdriver.Chrome(service=service, options=options)

def login_and_save(driver, email, password):
    driver.get("https://dashboard.tawk.to/login")
    wait = WebDriverWait(driver, 20)
    wait.until(EC.visibility_of_element_located((By.ID, "email"))).send_keys(email)
    driver.find_element(By.ID, "password").send_keys(password)
    driver.find_element(By.ID, "submit-login").click()
    try:
        wait.until(EC.presence_of_element_located((By.ID, "tawk-admin-nav")))
        pickle.dump(driver.get_cookies(), open(COOKIES, "wb"))
        return True, "✅ Logged in and cookies saved."
    except:
        return False, "❌ Login failed. Please check credentials."

def load_cookies(driver):
    driver.get("https://dashboard.tawk.to")
    cookies = pickle.load(open(COOKIES, "rb"))
    for cookie in cookies:
        driver.add_cookie(cookie)
    return True

def update_description(driver, description, tags):
    url = "https://dashboard.tawk.to/#/admin/67e2d6b0e2fadb190964902c/channels/page"
    driver.get(url)
    wait = WebDriverWait(driver, 30)
    wait.until(EC.title_contains("Administration"))
    time.sleep(3)

    try:
        show_btn = WebDriverWait(driver, 5).until(
            EC.element_to_be_clickable((By.CSS_SELECTOR, ".c-show-page-content-dialog"))
        )
        driver.execute_script("arguments[0].click();", show_btn)
        time.sleep(2)
    except:
        pass

    driver.execute_script("window.scrollTo(0, document.body.scrollHeight);")
    time.sleep(2)
    WebDriverWait(driver, 10).until(EC.element_to_be_clickable((By.ID, "description"))).clear()
    driver.find_element(By.ID, "description").send_keys(description)
    driver.find_element(By.ID, "tags").clear()
    driver.find_element(By.ID, "tags").send_keys(tags)
    driver.execute_script("arguments[0].click();", driver.find_element(By.ID, "submit"))
    return "✅ Description and tags updated."

if "logged_in" not in st.session_state:
    st.session_state.logged_in = False

driver = start_browser()

if not st.session_state.logged_in and not os.path.exists(COOKIES):
    st.subheader("🔐 Login to Tawk.to")
    email = st.text_input("Email")
    password = st.text_input("Password", type="password")
    if st.button("Login"):
        success, msg = login_and_save(driver, email, password)
        st.success(msg) if success else st.error(msg)
        st.session_state.logged_in = success
elif os.path.exists(COOKIES):
    load_cookies(driver)
    st.session_state.logged_in = True

if st.session_state.logged_in:
    st.subheader("✏️ Edit Description & Tags")
    new_desc = st.text_input("New Description")
    new_tags = st.text_input("New Tags")
    if st.button("Update"):
        msg = update_description(driver, new_desc, new_tags)
        st.success(msg)
    if st.button("Logout"):
        os.remove(COOKIES)
        st.session_state.logged_in = False
        st.experimental_rerun()
