*** Variables ***
${DRIVER_REQUESTED_PACKAGES_BUTTON}                     "Requested packages"
${DRIVER_REQUESTED_PACKAGES_AVAILABLE_BUTTON}            [data-testid="btn-available-0"]
${DRIVER_REQUESTED_PACKAGES_BID_PRICE_CHECKBOX}          [data-testid="check-carrier-offer-0"]
${DRIVER_REQUESTED_PACKAGES_BID_PRICE_INPUT}             [name="Request.CarrierOfferAmount"]
${DRIVER_REQUESTED_PACKAGES_ALL_CHECKBOXES}              xpath=//input[starts-with(@data-testid, 'check-carrier-offer-')]
${DRIVER_REQUESTED_PACKAGES_FIRST_CHECKBOX}              xpath=(//input[starts-with(@data-testid, 'check-carrier-offer-')])[1]