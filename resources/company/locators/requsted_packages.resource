*** Variables ***
${COMPANY_PACKAGES_AVAILABLE_BUTTON}            [data-testid="btn-available-0"]
${COMPANY_PACKAGES_REJECT_BUTTON}               [data-testid="btn-reject-0"]
${COMPANY_PACKAGES_ALL_AVAILABLE_BUTTONS}       xpath=//button[starts-with(@data-testid, 'btn-available-')]
${COMPANY_PACKAGES_FIRST_AVAILABLE_BUTTON}      xpath=(//button[starts-with(@data-testid, 'btn-available-')])[1]

${COMPANY_PACKAGES_BID_INPUT}                   [name="Form.CarrierOfferAmount"]
${COMPANY_PACKAGES_CAR_DROPDOWN}                [name="Form.CarId"]
${COMPANY_PACKAGES_DRIVER_DROPDOWN}             [name="Form.CompanyDriverId"]
${COMPANY_PACKAGES_SAVE_BUTTON}                 "Save"