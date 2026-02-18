*** Variables ***
# =============================================================================
# MEJ Robot Framework Tests - Travel Agency/Hotel Registration Locators
# =============================================================================
# Locators for Travel Agency/Hotel registration process.
# Structure: Page 1 (Personal) -> Finish - NO Page 2 or Page 3!
# This is the simplest registration - only personal information required.
# =============================================================================

# *** First page - Personal Information ***
${FIRST_PAGE_REGISTER_TA_NAME_INPUT}                           [name="Model.FirstName"]
${FIRST_PAGE_REGISTER_TA_LAST_NAME_INPUT}                      [name="Model.LastName"]
${FIRST_PAGE_REGISTER_TA_DIAL_DROPDOWN}                        [class="form-select form-input-select"] >> nth=0
${FIRST_PAGE_REGISTER_TA_PHONE_INPUT}                          //label[contains(text(), "Phone")]/preceding-sibling::input
${FIRST_PAGE_REGISTER_TA_EMAIL_INPUT}                          [name="Model.Email"]
${FIRST_PAGE_REGISTER_TA_PASSWORD_INPUT}                       [name="Model.Password"]
${FIRST_PAGE_REGISTER_TA_CONFIRMED_PASSWORD_INPUT}             [name="Model.ConfirmPassword"]
${FIRST_PAGE_REGISTER_TA_TERMS_OF_USE_CHECKBOX}                //input[@type="checkbox"][following-sibling::*[contains(text(), 'I agree with')]]
${FIRST_PAGE_REGISTER_TA_SUBMIT_BUTTON}                        [class="x-btn x-btn-primary"]

# *** Second page - SKIPPED for Travel Agency ***
# Travel Agency does NOT have Languages & Experience page like Driver

# *** Third page - SKIPPED for Travel Agency ***
# Travel Agency does NOT have Business Details page like Driver and Shuttle Company
# Registration ends after personal information!

# *** Finish page - Verification ***
${REGISTER_TA_FINISH_PAGE_EMAIL_TEXTAREA}                      [class="notification-component alert alert-dismissible fade show alert-primary notification-component-visible"]
${REGISTER_TA_FINISH_PAGE_EMAIL_TEXT_FOR_VERIFY}               Verification email was sent, check your email.
