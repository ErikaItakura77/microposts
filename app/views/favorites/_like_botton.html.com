<% unless current_user.id == micropost.user_id %>
  <% if current_user.likes?(micropost) %>
    <%= form_for(current_user.favorites.find_by(micropost_id: micropost.id), html: { method: :delete }) do |f| %>
     <%= hidden_field_tag :micropost_id, micropost.id %>
     <%= f.submit 'Unlike', class: 'btn btn-success btn-xs' %>
    <% end %>
  <% else %>
    <%= form_for(current_user.favorites.build) do |f| %>
     <%= hidden_field_tag :micropost_id, micropost.id %>
     <%= f.submit 'Like', class: 'btn btn-info btn-xs' %>
    <% end %>
  <% end %>
<% end %>  