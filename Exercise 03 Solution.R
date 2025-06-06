# ## Exercise 3
# 
# In RStudio on Posit Cloud, create a new R script do the following.
# 
# 1. Load the tidyverse.
# 2. Import and explore `customer_data` using the functions we've covered.
# 3. Provide at least one interesting numeric summary and one interesting 
# visualization using discrete variables only.
# 4. Practice good coding conventions: Comment often, write in consecutive lines of code using the `|>`, 
# and use the demonstrated style (e.g., variable names, spacing within functions).
# 5. Export the R script and upload to Canvas.

# Five points total, one point each for:
#   
# - Loading the tidyverse.
# - Providing at least one numeric summary.
# - Providing at least one visualization.
# - Following good coding conventions (provide feedback on this point).
# - Submitting an R script.

# Load the tidyverse.
library(tidyverse)

# Import data.
customer_data <- read_csv("customer_data.csv")

customer_data

# At least one interesting numeric summary. For example, the number of
# "high income" customers by gender.
customer_data |> 
  mutate(high_income = income > 120000) |> 
  count(gender, high_income) |> 
  arrange(desc(n))

# At least one interesting visualization. For example, the top 10
# most commonly used word for 5-star reviews.
customer_data |>
  filter(star_rating == 5) |> 
  select(review_text) |> 
  tidytext::unnest_tokens(word, review_text) |> 
  drop_na(word) |> 
  anti_join(tidytext::stop_words) |> 
  count(word) |> 
  arrange(desc(n)) |> 
  slice(1:10) |> 
  mutate(word = fct_reorder(word, n)) |>
  ggplot(aes(x = n, y = word)) +
  geom_col() +
  labs(title = "Most Commonly Used Words for 5-Star Reviews")

