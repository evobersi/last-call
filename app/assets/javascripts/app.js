console.log("LOADED APP.JS");
var Product = Backbone.Model.extend({
  urlRoot: "/search",
  initialize: function() {},
  load: function() {},
});

var ProductList = Backbone.Collection.extend({
  model: Product,
  url: "/search_products",
  initialize: function(options) {
    this.search_id = options.search_id;
    console.log(this.search_id);
    this.load();
  },

  load: function(){
    var self = this;
    this.fetch({
      data: "search_id=" + this.search_id,
      reset: true,
      success: function(model, response, options){
        console.log("success");
        console.log(response);
        self.parse(response);
      },
      error: function(model, response, options){
        console.log("error");
        console.log(response);
      }, 
    });
  },

  parse: function(response) {
    console.log(response.products);
    return response.products;
  }
});

var WatchList = Backbone.Collection.extend({
  url: "products",
  model: Product
});

// var productList = new ProductList();

// setup router for the products route 
var ProductRouter = Backbone.Router.extend({
  routes: {
    "search/:id" : "getProductInfo"
  },

  getProductInfo: function(id){
    // pass in url params
    console.log("getProductInfo: " + id);
    window.productList = new ProductList({search_id: id});
    new ProductListView({collection: productList});
  }
});

new ProductRouter();

var FormView = Backbone.View.extend({
  // set form as the el
  el: "form.search",

  initialize: function() {
    console.log("INIT FORM VIEW!");
  },

  events: {
    "submit" : "submitted"
  },

  submitted: function(e) {
    console.log("SSSSSSUBMIT!");
    e.preventDefault();
    var name = this.$el.find("input[name='title']").val();
    Backbone.history.navigate("search/" + encodeURI(name), { trigger: true });
    window.location.reload();
  }
});

new FormView();

var ProductListView = Backbone.View.extend({
  tagName: "ul",

  className: "results",

  initialize: function(item) {
    console.log('ProductListView initialized');
    this.listenTo(this.collection, "reset", this.render);
    this.listenTo(this.collection, "change:added", this.addToWatchList)

    this.watchList = new WatchList();
  },

  render: function(response){
    self = this;
    _.each(response.models, function(products){
      var their_id = products.get('id');
      products.set('shopSenseId', their_id);
      products.unset('id');
      // console.log(products.id);
      var view = new IndividualProductView({model: products})
      console.log(view);
      $("body").append(self.el);
      $(self.el).append(view.el);
      console.log('appended!');
    });
    // console.log(response.models);
    // this.collection.each(this.addOne, this);
  },

  addOne: function(){
    self = this;
    var view = new IndividualProductView({model: product});
    this.$el.append(view.el);
    console.log('Rendered');
  },

  addToWatchList: function(search) {
    this.watchList.create(search.toJSON());
  }
});

// var productListView = new ProductListView{collection: ProductList};

var IndividualProductView = Backbone.View.extend({
  tagName: "li", 
  template: _.template($("script[type='text/html']").html()),

  initialize: function() {
    console.log('IndividualProductView initialized');
    this.render();
  },

  events: {
    "click button.add": "add"
  },

  render: function() {
    this.$el.html(this.template(this.model.attributes));
  },

  add: function() {
    console.log(this.model.attributes);
    this.model.set("added", true);
    // console.log(this.model.attributes);
  }
});

Backbone.history.start();

$(function(){
  console.log("loaded app.js");
})
