*** Variables ***
${MAIN_REGISTER_BUTTON}    css=button.tab-button >> text=Sign Up

# *** Sign UP page ***
${SIGN_UP_DRIVER_CHECKBOX}                  css=label.form-check-label:has-text("Driver")
${SIGN_UP_SHUTTLE_COMPANY_CHECKBOX}         css=label.form-check-label:has-text("Shuttle Company")
${SIGN_UP_HOTEL_CHECKBOX}                   css=label.form-check-label:has-text("Travel Agency/Hotel")
${SIGN_UP_SELECT_BUTTON}                    css=button.x-btn-primary:has-text("Select")

# *** Tabs on Type Selection Page ***
${SIGN_UP_LOGIN_TAB}                        css=.tab-button
${SIGN_UP_SIGNUP_TAB_ACTIVE}                css=.tab-button-active


