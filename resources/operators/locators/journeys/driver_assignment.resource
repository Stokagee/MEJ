*** Variables ***
${JOURNEYS_DRIVER_ASSIGNMENT_TAB_BUTTON}                    [data-testid="journey-panel-tab-carrier-assignment"]
${JOURNEYS_DRIVER_ASSIGNMENT_TAB_MPV_BUTTON}                xpath=//tr[.//a[contains(., 'Mr. Mpv')]]//button[starts-with(@data-testid, 'carrier-assignment-requests-assign-button')]