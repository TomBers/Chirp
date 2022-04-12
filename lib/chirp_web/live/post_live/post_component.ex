defmodule ChirpWeb.PostLive.PostComponent do
  use ChirpWeb, :live_component

  def render(assigns) do
    ~H"""
      <div class="container">
        <%= @post.body %> |
        <a href="#" phx-click="like" phx-target={@myself}>
        Like (<%= @post.likes_count %>)
        </a> |
        <a href="#" phx-click="repost" phx-target={@myself}>
        Repost (<%= @post.reposts_count %>)
        </a> |
        <span><%= live_patch "Edit", to: Routes.post_index_path(@socket, :edit, @post) %></span> |
        <span><%= link "Delete", to: "#", phx_click: "delete", phx_value_id: @post.id, data: [confirm: "Are you sure?"] %></span>
      </div>
    """
  end

  def handle_event("like", _, socket) do
    Chirp.Timeline.inc_likes(socket.assigns.post)
    {:noreply, socket}
  end

  def handle_event("repost", _, socket) do
    Chirp.Timeline.inc_repost(socket.assigns.post)
    {:noreply, socket}
  end
end
