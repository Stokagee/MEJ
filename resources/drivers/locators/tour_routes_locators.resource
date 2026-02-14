*** Variables ***

${TOUR_ROUTES_CREATE_NEW_ROUTE_BUTTON}         [class="tile-button inflex-col-center-center m-2 position-relative"]
${TOUR_ROUTES_FROM_INPUT}                      css=.col-9.d-flex.align-items-center.p-0.relative.d-flex.justify-content-center >> nth=0 >> input
${TOUR_ROUTES_LIST_FIRST_ITEM}                 css=.ddl-item >> nth=0
${TOUR_ROUTES_TO_INPUT}                        css=.col-9.d-flex.align-items-center.p-0.relative.d-flex.justify-content-center >> nth=1 >> input
${TOUR_ROUTES_DATE_PICKER_INPUT}               css=.input.form-control.small-input >> nth=1
${TOUR_ROUTES_TIME_AT_INPUT}                   input[placeholder="At"]:visible
${TOUR_ROUTES_TIME_TO_INPUT}                   input[placeholder="(Optional) To"]:visible
${TOUR_ROUTES_CHECKBOX_LABEL}                  [class="form-check-input"]
${TOUR_ROUTES_PRICE_INPUT}                     [data-testid="offered-price-amount"] 
${TOUR_ROUTES_SUBMIT_BUTTON}                   css=.x-btn.x-btn-primary.w-fit-content.me-2:has-text("Save")
${TOUR_ROUTES_CANCEL_BUTTON}                   css=.x-btn.x-btn-secondary.w-fit-content:has-text("Cancel")
${TOUR_ROUTES_APPROVE_BUTTON}                  css=.x-btn:has-text("Approve"):visible >> nth=1
