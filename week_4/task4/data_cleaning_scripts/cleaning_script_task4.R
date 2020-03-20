# The data is in files boing-boing-candy-2015.xlxs, boing-boing-candy-2016.xlxs and boing-boing-candy-2017.xlxs. Bear in mind that this is trickier compared with tasks 1, 2 & 3.
# 
# More information on this data is available here https://www.scq.ubc.ca/so-much-candy-data-seriously/
# 
#Some cleaning hints
# 
# You’ll need to combine these three datasets together.
# The column country is particularly messy, you will likely need to do some ‘hard coding’ here!
#   
#   

library(tidyverse)
library(here)
library(janitor)
library(tidyr)
library(readxl)


#Reads file and imports it as a data.frame

candy_data_2015 <- read_xlsx(here("raw_data/boing-boing-candy-2015.xlsx"))

candy_data_2016 <- read_xlsx(here("raw_data/boing-boing-candy-2016.xlsx"))

candy_data_2017 <- read_xlsx(here("raw_data/boing-boing-candy-2017.xlsx"))

#Checking dimesion of data

dim(candy_data_2015) #5630  124

dim(candy_data_2016) #1259  123

dim(candy_data_2017) #2460  120

#checking names to replace

names(candy_data_2015)

names(candy_data_2016)

names(candy_data_2017)

#cleaning column names and dropping unnecesary ones

candy_cleandata_2015 <-  clean_names(candy_data_2015) %>% 
  select(-c(
    timestamp,
    please_estimate_the_degrees_of_separation_you_have_from_the_following_folks_beyonce_knowles,
    please_estimate_the_degrees_of_separation_you_have_from_the_following_folks_donald_trump,
    please_estimate_the_degrees_of_separation_you_have_from_the_following_folks_hillary_clinton,
    please_estimate_the_degrees_of_separation_you_have_from_the_following_folks_jj_abrams,
    please_estimate_the_degrees_of_separation_you_have_from_the_following_folks_thom_yorke,
    please_estimate_the_degrees_of_separation_you_have_from_the_following_folks_malala_yousafzai,
    please_estimate_the_degrees_of_separation_you_have_from_the_following_folks_jk_rowling,
    please_estimate_the_degrees_of_separation_you_have_from_the_following_folks_bruce_lee,
    which_day_do_you_prefer_friday_or_sunday,
    please_estimate_the_degree_s_of_separation_you_have_from_the_following_celebrities_francis_bacon_1561_1626,
    please_estimate_the_degree_s_of_separation_you_have_from_the_following_celebrities_kevin_bacon,
    please_estimate_the_degree_s_of_separation_you_have_from_the_following_celebrities_bieber,
    please_estimate_the_degree_s_of_separation_you_have_from_the_following_celebrities_beyonce,
    please_estimate_the_degree_s_of_separation_you_have_from_the_following_celebrities_jj_abrams,
    please_estimate_the_degree_s_of_separation_you_have_from_the_following_celebrities_jk_rowling,
    fill_in_the_blank_imitation_is_a_form_of,
    if_you_squint_really_hard_the_words_intelligent_design_would_look_like,
    what_is_your_favourite_font,
    fill_in_the_blank_taylor_swift_is_a_force_for,
    that_dress_that_went_viral_early_this_year_when_i_first_saw_it_it_was,
    check_all_that_apply_i_cried_tears_of_sadness_at_the_end_of,
    betty_or_veronica,
    guess_the_number_of_mints_in_my_hand,
    please_list_any_items_not_included_above_that_give_you_despair,
    please_list_any_items_not_included_above_that_give_you_joy,
    please_leave_any_remarks_or_comments_regarding_your_choices

         )) %>% 
    rename(  age = how_old_are_you,
            trick_or_treat = are_you_going_actually_going_trick_or_treating_yourself
            ) %>%  
            mutate("year" = "2015") %>% 
            rowid_to_column("user_id") %>% 
            pivot_longer(cols = 4:necco_wafers,
                       names_to = "candy",
                       values_to = "rating"
          )

names(candy_cleandata_2015)

candy_cleandata_2016 <- clean_names(candy_data_2016) %>% 
  select(-c(timestamp, 
            which_country_do_you_live_in, 
            which_state_province_county_do_you_live_in,
            when_you_see_the_above_image_of_the_4_different_websites_which_one_would_you_most_likely_check_out_please_be_honest,
            do_you_eat_apples_the_correct_way_east_to_west_side_to_side_or_do_you_eat_them_like_a_freak_of_nature_south_to_north_bottom_to_top,
            which_day_do_you_prefer_friday_or_sunday,
            please_estimate_the_degree_s_of_separation_you_have_from_the_following_celebrities_francis_bacon_1561_1626,
            please_estimate_the_degree_s_of_separation_you_have_from_the_following_celebrities_kevin_bacon,
            please_estimate_the_degree_s_of_separation_you_have_from_the_following_celebrities_bieber,
            please_estimate_the_degree_s_of_separation_you_have_from_the_following_celebrities_beyonce,
            please_estimate_the_degree_s_of_separation_you_have_from_the_following_celebrities_jj_abrams,
            please_estimate_the_degree_s_of_separation_you_have_from_the_following_celebrities_jk_rowling,
            what_is_your_favourite_font,
            that_dress_that_went_viral_a_few_years_back_when_i_first_saw_it_it_was,
            betty_or_veronica,
            guess_the_number_of_mints_in_my_hand,
            please_leave_any_witty_snarky_or_thoughtful_remarks_or_comments_regarding_your_choices,
            please_list_any_items_not_included_above_that_give_you_despair,
            please_list_any_items_not_included_above_that_give_you_joy
            )) %>% 
  rename(age = how_old_are_you,
         trick_or_treat = are_you_going_actually_going_trick_or_treating_yourself,
          gender = your_gender) %>% 
  mutate("year" = "2016") %>% 
  rowid_to_column("user_id") %>% 
  pivot_longer(cols = 5:york_peppermint_patties_ignore,
               names_to = "candy",
               values_to = "rating"
  )

#names(candy_cleandata_2016)

candy_cleandata_2017 <- clean_names(candy_data_2017) %>% 
  select(-c(internal_id, 
            q4_country, 
            q5_state_province_county_etc,
            q7_joy_other,                                                                    
            q8_despair_other,                                                                
            q9_other_comments,                                                               
            q10_dress,                                                                       
            x114,                                                                           
            q11_day,                                                                         
            q12_media_daily_dish,                                                            
            q12_media_science,                                                               
            q12_media_espn,                                                                  
            q12_media_yahoo,                                                                 
            click_coordinates_x_y)) %>% 
  rename(age = q3_age,
         trick_or_treat = q1_going_out,
         gender = q2_gender,
         x100_grand_bar = q6_100_grand_bar,
         anonymous_brown_globs_that_come_in_black_and_orange_wrappers_a_k_a_mary_janes = q6_anonymous_brown_globs_that_come_in_black_and_orange_wrappers_a_k_a_mary_janes,
         any_full_sized_candy_bar = q6_any_full_sized_candy_bar,
         black_jacks = q6_black_jacks,
         bonkers_the_candy = q6_bonkers_the_candy,
         bonkers_the_board_game = q6_bonkers_the_board_game,
         bottle_caps = q6_bottle_caps,
         boxo_raisins = q6_boxo_raisins,
         broken_glow_stick = q6_broken_glow_stick,
         butterfinger = q6_butterfinger,
         cadbury_creme_eggs = q6_cadbury_creme_eggs,
         candy_corn = q6_candy_corn,
         candy_that_is_clearly_just_the_stuff_given_out_for_free_at_restaurants = q6_candy_that_is_clearly_just_the_stuff_given_out_for_free_at_restaurants,
         caramellos = q6_caramellos,
         cash_or_other_forms_of_legal_tender = q6_cash_or_other_forms_of_legal_tender,
         chardonnay = q6_chardonnay,
         chick_o_sticks_we_don_t_know_what_that_is = q6_chick_o_sticks_we_don_t_know_what_that_is,
         chiclets = q6_chiclets,
         coffee_crisp = q6_coffee_crisp,
         creepy_religious_comics_chick_tracts = q6_creepy_religious_comics_chick_tracts,
         dental_paraphenalia = q6_dental_paraphenalia,
         dots = q6_dots,
         dove_bars = q6_dove_bars,
         fuzzy_peaches = q6_fuzzy_peaches,
         generic_brand_acetaminophen = q6_generic_brand_acetaminophen,
         glow_sticks = q6_glow_sticks,
         goo_goo_clusters = q6_goo_goo_clusters,
         good_n_plenty = q6_good_n_plenty,
         gum_from_baseball_cards = q6_gum_from_baseball_cards,
         gummy_bears_straight_up = q6_gummy_bears_straight_up,
         hard_candy = q6_hard_candy,
         healthy_fruit = q6_healthy_fruit,
         heath_bar = q6_heath_bar,
         hersheys_dark_chocolate = q6_hersheys_dark_chocolate,
         hershey_s_milk_chocolate = q6_hershey_s_milk_chocolate,
         hersheys_kisses = q6_hersheys_kisses,
         hugs_actual_physical_hugs = q6_hugs_actual_physical_hugs,
         jolly_rancher_bad_flavor = q6_jolly_rancher_bad_flavor,
         jolly_ranchers_good_flavor = q6_jolly_ranchers_good_flavor,
         joy_joy_mit_iodine = q6_joy_joy_mit_iodine,
         junior_mints = q6_junior_mints,
         senior_mints = q6_senior_mints,
         kale_smoothie = q6_kale_smoothie,
         kinder_happy_hippo = q6_kinder_happy_hippo,
         kit_kat = q6_kit_kat,
         laffy_taffy = q6_laffy_taffy,
         lemon_heads = q6_lemon_heads,
         licorice_not_black = q6_licorice_not_black,
         licorice_yes_black = q6_licorice_yes_black,
         lindt_truffle = q6_lindt_truffle,
         lollipops = q6_lollipops,
         mars = q6_mars,
         maynards = q6_maynards,
         mike_and_ike = q6_mike_and_ike,
         milk_duds = q6_milk_duds,
         milky_way = q6_milky_way,
         regular_m_ms = q6_regular_m_ms,
         peanut_m_m_s = q6_peanut_m_m_s,
         blue_m_ms = q6_blue_m_ms,
         red_m_ms = q6_red_m_ms,
         green_party_m_ms = q6_green_party_m_ms,
         independent_m_ms = q6_independent_m_ms,
         abstained_from_m_ming = q6_abstained_from_m_ming,
         minibags_of_chips = q6_minibags_of_chips,
         mint_kisses = q6_mint_kisses,
         mint_juleps = q6_mint_juleps,
         mr_goodbar = q6_mr_goodbar,
         necco_wafers = q6_necco_wafers,
         nerds = q6_nerds,
         nestle_crunch = q6_nestle_crunch,
         nown_laters = q6_nown_laters,
         peeps = q6_peeps,
         pencils = q6_pencils,
         pixy_stix = q6_pixy_stix,
         real_housewives_of_orange_county_season_9_blue_ray = q6_real_housewives_of_orange_county_season_9_blue_ray,
         reese_s_peanut_butter_cups = q6_reese_s_peanut_butter_cups,
         reeses_pieces = q6_reeses_pieces,
         reggie_jackson_bar = q6_reggie_jackson_bar,
         rolos = q6_rolos,
         sandwich_sized_bags_filled_with_boo_berry_crunch = q6_sandwich_sized_bags_filled_with_boo_berry_crunch,
         skittles = q6_skittles,
         smarties_american = q6_smarties_american,
         smarties_commonwealth = q6_smarties_commonwealth,
         snickers = q6_snickers,
         sourpatch_kids_i_e_abominations_of_nature = q6_sourpatch_kids_i_e_abominations_of_nature,
         spotted_dick = q6_spotted_dick,
         starburst = q6_starburst,
         sweet_tarts = q6_sweet_tarts,
         swedish_fish = q6_swedish_fish,
         sweetums_a_friend_to_diabetes = q6_sweetums_a_friend_to_diabetes,
         take_5 = q6_take_5,
         tic_tacs = q6_tic_tacs,
         those_odd_marshmallow_circus_peanut_things = q6_those_odd_marshmallow_circus_peanut_things,
         three_musketeers = q6_three_musketeers,
         tolberone_something_or_other = q6_tolberone_something_or_other,
         trail_mix = q6_trail_mix,
         twix = q6_twix,
         vials_of_pure_high_fructose_corn_syrup_for_main_lining_into_your_vein = q6_vials_of_pure_high_fructose_corn_syrup_for_main_lining_into_your_vein,
         vicodin = q6_vicodin,
         whatchamacallit_bars = q6_whatchamacallit_bars,
         white_bread = q6_white_bread,
         whole_wheat_anything = q6_whole_wheat_anything,
         york_peppermint_patties = q6_york_peppermint_patties,
         ) %>% 
  mutate("year" = "2017") %>% 
  rowid_to_column("user_id") %>% 
  pivot_longer(cols = 5:york_peppermint_patties,
               names_to = "candy",
               values_to = "rating"
  )

#Join tables

candy_data_clean <- bind_rows(candy_cleandata_2016, candy_cleandata_2017)

#names(candy_cleandata_2017)

#Writes/creates cleaned CSV file

write_csv(candy_data_clean, "clean_data/candy_data_clean.csv")

