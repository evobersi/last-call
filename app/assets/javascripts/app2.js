// initialize the Product collection 
// var ProductList = Backbone.Collection.extend({
//   model: Product,
//   url: "searches",

//   initialize: function(search) {
//     this.title = search.title
//   },

//   load: function(){
//     this.fetch({
//       data: {fts: this.title},
//       reset: true
//     });
//   }
// });

// new ProductList();

// 
// var Product = Backbone.Model.extend({
//   productSrc: function() {
//     var src = this.get("search.products.model.image.sizes.Large.url");
//     // console.log(src);
//     if(src != "N/A") {
//       return src;
//     } else {
//       return "http://fillmurray.com/200/300";
//       } 
//     }
//   });

// new Product();

// setup router for the products route 
var ProductRouter = Backbone.Router.extend({
  routes: {
    "search/:id" : "getProductInfo"
  },

  // search: function(title){
  //   var products = new ProductList({title: title});
  //   this.loadView(new )
  // }

  getProductInfo: function(id){
// pass in url params
    new ProductView({id: id})
  }
});

new ProductRouter();

// var WatchList = Backbone.Collection.extend({
//   url: "products",
//   model: Product
// });


var FormView = Backbone.View.extend({
  // set form as the el
  el: "form",
  events: {
    "submit" : "submitted"
  },

  submitted: function(e) {
    e.preventDefault();

  var name = this.$el.find("input[name='title']").val();
  Backbone.history.navigate("search/" + name, { trigger: true });
  window.location.reload();
  }
});

new FormView();

var ProductView = Backbone.View.extend({
  // create a blank div
  tagName: "div",

  initialize: function(item) {
    this.query = item.id;
    this.$el.appendTo($("body"));
    this.render();
    this.getProduct();
  },

  getProduct: function(){
    var route = "/searches?fts=" + this.query;
    $.ajax({
      method: "GET",
      url: route,
      dataType: "json",
      success: this.receiveProduct, 
      context: this,
    });
  },

  receiveProduct: function(search) { 
    console.log(search.products);
    _.each(search.products, function(product){
      var view = new IndividualProductView({model: product});
      this.$el.append(view.el);
    }, this);
  }
});

var IndividualProductView = Backbone.View.extend({
  tagName: "li", 
  template: _.template($("script[type='text/html']").html()),

  render: function() {
    this.$el.html(this.template(this.model));
  },

  initialize: function() {
    this.render();
  }
});

// new Results();
// Results.fetch();

Backbone.history.start();