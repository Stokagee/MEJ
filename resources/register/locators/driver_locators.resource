*** Variables ***
# *** First page ***    
${FIRST_PAGE_REGISTER_DRVIER_NAME_INPUT}                        [name="Model.FirstName"]
${FIRST_PAGE_REGISTER_DRVIER_LAST_NAME_INPUT}                   [name="Model.LastName"]
${FIRST_PAGE_REGISTER_DRIVER_DIAL_DROPDOWN}                     [class="form-select form-input-select"]
${FIRST_PAGE_REGISTER_DRVIER_PHONE_INPUT}                       css=label.form-input-placeholder:has-text("Phone")
${FIRST_PAGE_REGISTER_DRVIER_EMAIL_INPUT}                       [name="Model.Email"]
${FIRST_PAGE_REGISTER_DRVIER_PASSWORD_INPUT}                    [name="Model.Password"]
${FIRST_PAGE_REGISTER_DRVIER_CONFIRMED_PASSWORD_INPUT}          [name="Model.ConfirmPassword"]
${FIRST_PAGE_REGISTER_DRVIER_TERMS_OF_USE_CHECKBOX}             css=label.form-check-label:has-text("I agree with")
${FIRST_PAGE_REGISTER_DRIVER_NEXT_BUTTON}                       [class="x-btn x-btn-primary"]

# *** Second page ***
${SECOND_PAGE_REGISTER_DRIVER_LANGUAGE_DROPDOWN}                css=label.form-input-placeholder:has-text("Native language")
${SECOND_PAGE_REGISTER_DRIVER_LEVEL_OF_ENGLISH_DROPDOWN}        css=label.form-input-placeholder:has-text("Level")
${SECOND_PAGE_REGISTER_DRIVER_ADD_NEW_LANGUGAE_BUTTON}          [class="x-btn x-btn-secondary"]
${SECOND_PAGE_REGISTER_DRIVER_ANOTHER_LANGUAGE_DROPDOWN}        css=label.form-input-placeholder:has-text("Additional language")
${SECOND_PAGE_REGISTER_DRIVER_DRIVING_EXPERINENCE_DROPDOWN}     css=label.form-input-placeholder:has-text("Years of Driving Experience")
${SECOND_PAGE_REGISTER_DRIVER_ABOUT_ME_INPUT}                   [name="Model.AboutMe"]
${SECOND_PAGE_REGISTER_DRIVER_NEXT_BUTTON}                      css=button.x-btn-primary:has-text("Next")

# *** Third page ***
${THIRD_PAGE_REGISTER_DRIVER_COUNTRY_DROPDOWN}                  [name="Model.CountryId"]
${THIRD_PAGE_REGISTER_DRIVER_BUSINESS_NUMBER_INPUT}             [name="Model.IdentificationNumber"]
${THIRD_PAGE_REGISTER_DRIVER_VAT_PAYER_CHECKBOX}                css=label.form-check-label:has-text("I am the VAT Payer")
${THIRD_PAGE_REGISTER_DRIVER_VAT_NUMBER_INPUT}                  [name="Model.VatNumber"]
${THIRD_PAGE_REGISTER_DRIVER_BUSINESS_NAME_INPUT}               [name="Model.BusinessName"]
${THIRD_PAGE_REGISTER_DRIVER_BUSINESS_ADRESS_INPUT}             [name="Model.BusinessStreet"]
${THIRD_PAGE_REGISTER_DRIVER_BUSINESS_CITY-INPUT}               [name="Model.BusinessCity"]
${THIRD_PAGE_REGISTER_DRIVER_ZIP_CODE_INPUT}                    [name="Model.BusinessZipCode"]
${THIRD_PAGE_REGISTER_DRIVER_IBAN_INPUT}                        [name="Model.IbanInEuro"]
${THIRD_PAGE_REGISTER_DRIVER_BIC_INPUT}                         [name="Model.Bic"]
${THIRD_PAGE_REGISTER_DRIVER_FINISH_BUTTON}                     [class="x-btn x-btn-primary"]