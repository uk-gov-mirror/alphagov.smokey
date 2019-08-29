# Person descriptions
# ===================
@uk_national = false
@eu_national = false
@uk_domociled = false
@eu_domociled = false
@work_in_uk = false
@study_in_uk = false
@business_owner = false
@farmer = false
@sell_goods_in_uk = false
@eu_importer = false
@do_business_in_eu = false
@exporter_to_eu = false
@transporter_of_goods = false
@employer_of_norwegians = false
@data_sharer = false
@rely_on_copyright = false
@receive_eu_funding = false
@have_defence_contracts = false
@plan_to_travel_to_eu = false
@have_eu_property = false
@plan_to_join_family_in_uk = false
@travelling_to_uk_post_brexit = false

Given "I am a UK national" do @uk_national = true; end
Given "I am an EU national" do @eu_national = true; end
Given "I live in the UK" do @uk_domociled = true; end
Given "I live in the EU" do @eu_domociled = true; end
Given "I work in the UK" do @uk_domociled = true; @work_in_uk = true; end
Given "I study in the UK" do @uk_domociled = true; @study_in_uk = true; end
Given "I plan to travel to the EU after Brexit" do @plan_to_travel_to_eu = true; end
Given "I own property in the EU" do @have_eu_property = true; end
Given "I am a farmer" do @business_owner = true; @farmer = true; end
Given "I sell goods in the UK" do @sell_goods_in_uk = true; end
Given "I import goods from the EU" do @eu_importer = true; end
Given "I do business in the EU" do @do_business_in_eu = true; end
Given "I export goods to the EU" do @exporter_to_eu = true; end
Given "I transport goods across border" do @transporter_of_goods = true; end
Given "I employ Norwegians" do @employer_of_norwegians = true; end
Given "I share data with other EU organisations" do @data_sharer = true; end
Given "I rely on Copyright" do @rely_on_copyright = true; end
Given "I receive EU funding" do @receive_eu_funding = true; end
Given "I have defence contracts" do @have_defence_contracts = true; end

# Start page
# ==========

When "I start the brexit questionaire" do
  visit_path "/get-ready-brexit-check"
  click_link "Start now"
  visit_path "/get-ready-brexit-check/questions" # cache busts
end

# Questions
# =========

Then "I should be asked if I own a business" do
  expect(page).to have_content("Are you preparing a business or organisation for Brexit?")
  @business_owner ? choose('Yes', visible: false) : choose('No', visible: false)
  click_button "Next"
end

Then "I should be asked what my business does" do
  expect(page).to have_content("What does your business or organisation do?")
  check("Agriculture and farming", visible: false) if @farmer
  click_button "Next"
end

Then "I should be asked about my business activities" do
  expect(page).to have_content("Does your business or organisation do any of the following activities?")
  check("Sell goods or provide services in the UK", visible: false) if @sell_goods_in_uk
  check("Import from the EU", visible: false) if @eu_importer
  check("Export to the EU", visible: false) if @exporter_to_eu
  check("Provide services or do business in the EU", visible: false) if @do_business_in_eu
  check("Transporting goods across EU borders", visible: false) if @transporter_of_goods
  click_button "Next"
end

Then "I should be asked if I employ people from other European countries" do
  expect(page).to have_content("Do you employ anyone from another European country?")
  @employer_of_norwegians ? choose('Yes', visible: false) : choose('No', visible: false)
  click_button "Next"
end

Then "I should be asked if I share data across EU borders" do
  expect(page).to have_content("Do you exchange personal data with another organisation in Europe?")
  @data_sharer ? choose('Yes', visible: false) : choose('No', visible: false)
  check("Providing digital services available to Europe", visible: false) if @data_sharer
  click_button "Next"
end

Then "I should be asked if I rely on IP protection" do
  expect(page).to have_content("Do you use or rely on intellectual property (IP) protection?")
  @rely_on_copyright ? choose('Yes', visible: false) : choose('No', visible: false)
  check("Copyright", visible: false) if @rely_on_copyright
  click_button "Next"
end

Then "I should be asked about government funding" do
  expect(page).to have_content("Do you get EU or UK government funding?")
  @receive_eu_funding ? choose('Yes', visible: false) : choose('No', visible: false)
  check("EU funding", visible: false) if @receive_eu_funding
  click_button "Next"
end

Then "I should be asked if I service the public sector" do
  expect(page).to have_content("Do you sell your products or services to the public sector?")
  @have_defence_contracts ? choose('Yes', visible: false) : choose('No', visible: false)
  check("Defence contracts", visible: false) if @have_defence_contracts
  click_button "Next"
end

Then "I should be asked about my nationality" do
  expect(page).to have_content("What nationality are you?")
  if @eu_national
    choose('EU', visible: false)
  elsif @uk_national
    choose('UK', visible: false)
  else
    choose('Rest of world', visible: false)
  end
  click_button "Next"
end

Then "I should be asked if I plan to join an EU family member in the UK" do
  expect(page).to have_content("Do you plan to join an EU family member in the UK?")
  @plan_to_join_family_in_uk ? choose('Yes', visible: false) : choose('No', visible: false)
  click_button "Next"
end

Then "I should be asked where I live" do
  expect(page).to have_content("Where do you live?")
  if @eu_domociled
    choose('EU', visible: false)
  elsif @uk_domociled
    choose('UK', visible: false)
  else
    choose('Rest of world', visible: false)
  end
  click_button "Next"
end

Then "I should be asked what I do" do
  expect(page).to have_content("What do you do?")
  check("Study", visible: false) if @study_in_uk
  check("Work", visible: false) if @work_in_uk
  click_button "Next"
end

Then "I should be asked if I need to drive in the EU" do
  expect(page).to have_content("Do you need to drive in the EU?")
  @plan_to_travel_to_eu ? choose('Yes', visible: false) : choose('No', visible: false)
  check("You plan to drive", visible: false) if @plan_to_travel_to_eu
  click_button "Next"
end

Then "I should be asked if I plan to travel to the EU" do
  expect(page).to have_content("Are you planning to travel to the EU after 31 October 2019?")
  @plan_to_travel_to_eu ? choose('Yes', visible: false) : choose('No', visible: false)
  check("You plan to drive", visible: false) if @plan_to_travel_to_eu
  click_button "Next"
end

Then "I should be asked if I want to travel to the UK after Brexit" do
  expect(page).to have_content("Are you planning to travel to the UK after 31 October 2019?")
  @travelling_to_uk_post_brexit ? choose('Yes', visible: false) : choose('No', visible: false)
  click_button "Next"
end

Then "I should be asked if I have property in the EU" do
  expect(page).to have_content("Are you planning to buy or do you already own property in the EU?")
  @have_eu_property ? choose('Yes', visible: false) : choose('No', visible: false)
  click_button "Next"
end

Then "I should be asked if I am an EU national" do
  expect(page).to have_content("Are you an EU national living in the UK?")
  @eu_national ? choose('Yes', visible: false) : choose('No', visible: false)
  click_button "Next"
end

# Results
# =======

Then "I should see the results page" do
  expect(page).to have_content("What you need to do now to prepare for Brexit")
end

Then "I should see confirmation of my answers" do
  expect(page).to have_content("Based on your answers, we know:")
  expect(page).to have_content("You are a UK national") if @uk_national
  expect(page).to have_content("You are an EU national") if @eu_national
  expect(page).to have_content("You live in the UK") if @uk_domociled
  expect(page).to have_content("You live in the EU") if @eu_domociled

  expect(page).to have_content("You plan to travel to the EU") if @plan_to_travel_to_eu
  expect(page).to have_content("You are planning to buy or already own property in the EU") if @have_eu_property

  expect(page).to have_content("You own or operate a business or organisation") if @business_owner
  expect(page).to have_content("You work in agriculture and farming") if @farmer
  expect(page).to have_content("Your business imports goods from the EU") if @eu_importer
  expect(page).to have_content("Your business transports goods across EU borders") if @transporter_of_goods
  expect(page).to have_content("Your business sells goods or services in the UK") if @sell_goods_in_uk
  expect(page).to have_content("You employ EU citizens") if @employer_of_norwegians
  expect(page).to have_content("You process personal data from the EU") if @data_sharer
  expect(page).to have_content("You use or rely on IP copyright protection") if @rely_on_copyright
  expect(page).to have_content("You receive EU government funding") if @receive_eu_funding
  expect(page).to have_content("You have defence contracts") if @have_defence_contracts
end

Then "I should see answers tailored to me" do
  # personal
  expect(page).to have_content("Check a passport for travel to Europe after Brexit") if @plan_to_travel_to_eu
  if @plan_to_travel_to_eu
    expect(page).to have_content("mobile roaming charges")
    expect(page).to have_content("travel insurance with health cover before travelling to the EU")
    expect(page).to have_content("Check if you need an International Driving Permit before you drive in the EU, EEA or Switzerland")
  end
  # business
  expect(page).to have_content("Check how to label food if you're selling it in the UK or EU") if @farmer
  expect(page).to have_content("Apply for the right to export seeds to the EU") if @farmer
  expect(page).to have_content("Disclose your designs before 31 October if you want unregistered protection in the UK and EU") if @rely_on_copyright
  expect(page).to have_content("You may want to ask your employees to check if they need to apply to the EU Settlement Scheme") if @employer_of_norwegians
  expect(page).to have_content("conformity assesment or conformity marking to sell your CE-marked goods in the UK or EU") if @eu_importer
end

# Email subscriptions
# ===================

Then "I click Subscribe link" do
  click_link "Subscribe"
end

Then /^I should be on the page "(.*?)"$/ do |path|
  page.has_current_path?(path)
end

Then "I click Subscribe button" do
  click_button "Subscribe"
end
