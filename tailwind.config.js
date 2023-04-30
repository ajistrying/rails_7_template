module.exports = {
  plugins: [
    require("@tailwindcss/forms"), 
    require("daisyui"),
    require('@tailwindcss/line-clamp'),
  ],
  daisyui: {
    themes: ["garden"],
  },
  content: [
    "./app/views/**/*.html.erb",
    "./app/helpers/**/*.rb",
    "./app/assets/stylesheets/**/*.css",
    "./app/javascript/**/*.js",
  ],
  extend: {
    fontWeight: ["responsive", "hover", "focus"],
    opacity: ["hover"],
    borderColor: ["hover", "focus"],
    margin: ["first", "last"],
    backgroundColor: ["odd", "even"],
    scale: ["hover", "active", "group-hover"],
  },
};
