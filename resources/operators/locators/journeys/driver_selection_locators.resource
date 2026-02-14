*** Variables ***    
${JOURNEYS_DRIVER_SELECTION_TAB_BUTTON}                  [data-testid="journey-panel-tab-carrier-selection"    ]
${JOURNEYS_DRIVER_SELECTION_SEARCH_BUTTON}               css=.x-btn.x-btn-primary.x-btn-sm.mi-btn-icon.mi-search >> nth=1
${JOURNEYS_DRIVER_SELECTION_DRVIER_CHECKBOX}             xpath=//a[text()="Mr. Mpv"]/ancestor::tr/td[1]/div/input
${JOURNEYS_DRIVER_SELECTION_SHUTTLE_COMPANY_CHECKBOX}    xpath=//a[text()="Shuttle Company"]/ancestor::tr/td[1]/div/input     
${JOURNEYS_DRIVER_SELECTION_REQUEST_NOW_BUTTON}          [data-testid="carrier-selection-request-now-button"]
${JOURNEYS_DRIVER_SELECTION_START_REQUESTING_BUTTON}     [data-testid="carrier-selection-start-requesting-button"]