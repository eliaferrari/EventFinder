(window.webpackJsonp=window.webpackJsonp||[]).push([[87],{434:function(t,i,e){"use strict";e.r(i);var r=e(3),n=e(2),o=e(68),s=e(114),a=e(13),p=e(1),u=e(12),h=e(100),c=e(97);var d=function(t){function i(i){t.call(this,{projection:i.projection,resolutions:i.resolutions}),this.crossOrigin_=void 0!==i.crossOrigin?i.crossOrigin:null,this.displayDpi_=void 0!==i.displayDpi?i.displayDpi:96,this.params_=i.params||{},this.url_=i.url,this.imageLoadFunction_=void 0!==i.imageLoadFunction?i.imageLoadFunction:h.b,this.hidpi_=void 0===i.hidpi||i.hidpi,this.metersPerUnit_=void 0!==i.metersPerUnit?i.metersPerUnit:1,this.ratio_=void 0!==i.ratio?i.ratio:1,this.useOverlay_=void 0!==i.useOverlay&&i.useOverlay,this.image_=null,this.renderedRevision_=0}return t&&(i.__proto__=t),i.prototype=Object.create(t&&t.prototype),i.prototype.constructor=i,i.prototype.getParams=function(){return this.params_},i.prototype.getImageInternal=function(t,i,e,r){i=this.findNearestResolution(i),e=this.hidpi_?e:1;var n=this.image_;if(n&&this.renderedRevision_==this.getRevision()&&n.getResolution()==i&&n.getPixelRatio()==e&&Object(p.g)(n.getExtent(),t))return n;1!=this.ratio_&&(t=t.slice(),Object(p.J)(t,this.ratio_));var o=[Object(p.E)(t)/i*e,Object(p.A)(t)/i*e];if(void 0!==this.url_){var u=this.getUrl(this.url_,this.params_,t,o,r);(n=new s.a(t,i,e,u,this.crossOrigin_,this.imageLoadFunction_)).addEventListener(a.a.CHANGE,this.handleImageChange.bind(this))}else n=null;return this.image_=n,this.renderedRevision_=this.getRevision(),n},i.prototype.getImageLoadFunction=function(){return this.imageLoadFunction_},i.prototype.updateParams=function(t){Object(u.a)(this.params_,t),this.changed()},i.prototype.getUrl=function(t,i,e,r,n){var o=function(t,i,e,r){var n=Object(p.E)(t),o=Object(p.A)(t),s=i[0],a=i[1],u=.0254/r;return a*n>s*o?n*e/(s*u):o*e/(a*u)}(e,r,this.metersPerUnit_,this.displayDpi_),s=Object(p.x)(e),a={OPERATION:this.useOverlay_?"GETDYNAMICMAPOVERLAYIMAGE":"GETMAPIMAGE",VERSION:"2.0.0",LOCALE:"en",CLIENTAGENT:"ol/source/ImageMapGuide source",CLIP:"1",SETDISPLAYDPI:this.displayDpi_,SETDISPLAYWIDTH:Math.round(r[0]),SETDISPLAYHEIGHT:Math.round(r[1]),SETVIEWSCALE:o,SETVIEWCENTERX:s[0],SETVIEWCENTERY:s[1]};return Object(u.a)(a,i),Object(c.a)(t,a)},i.prototype.setImageLoadFunction=function(t){this.image_=null,this.imageLoadFunction_=t,this.changed()},i}(h.a);new r.a({layers:[new o.a({extent:[-87.86511444236592,43.66506556483793,-87.59539405949707,43.82385256443007],source:new d({projection:"EPSG:4326",url:"http://138.197.230.93:8008/mapguide/mapagent/mapagent.fcgi?",useOverlay:!1,metersPerUnit:111319.4908,params:{MAPDEFINITION:"Library://Samples/Sheboygan/Maps/Sheboygan.MapDefinition",FORMAT:"PNG",VERSION:"3.0.0",USERNAME:"OLGuest",PASSWORD:"olguest"},ratio:2})})],target:"map",view:new n.a({center:[-87.7302542509315,43.744459064634],projection:"EPSG:4326",zoom:12})})}},[[434,0]]]);
//# sourceMappingURL=mapguide-untiled.js.map