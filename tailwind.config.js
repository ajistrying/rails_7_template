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
};
