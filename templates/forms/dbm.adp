<table border="0" width="50%">
<tr><td>
  <multiple name=elements>
    <if @elements.section@ not nil>
      <div style="font-size:small;font-weight:bold;text-align:center;background-color:#CCC;margin-top:0px;clear:both;">@elements.section@</div>
    </if>
    <if @elements.float@ not nil><if @elements.section@ not nil>
      <div>
      <ul style="padding:0;margin-bottom:10px;list-style-type:none;text-align:left;"></if></if>
      <group column="section">

      <if @elements.widget@ eq "hidden"> 
        <noparse><formwidget id=@elements.id@></noparse>
      </if>

      <else>
        <if @elements.widget@ eq "submit">
              <group column="widget">
                <noparse><formwidget id="@elements.id@"></noparse>
              </group>
        </if>

        <else>
	  <if @elements.float@ not nil and @elements.section@ not nil>
	    <!-- section begin -->
            <li style="display:inline;float:@elements.float@;">
          </if>
          <if @elements.label@ not nil>
            <noparse>
              <if \@formerror.@elements.id@\@ not nil>
                <div class="form-label-error">
              </if>
            </noparse>
	    <if @elements.float@ not nil>
              <if @elements.section@ not nil>
                 <!-- floated and sectioned element begin -->
                 <div style="font-size:small;<if @elements.text_align@ not nil>text-align:@elements.text_align@;</if><else><if @elements.style@ not nil>float:@elements.style@;</if></else>">
              </if>
              <else>
                <div style="background-color:#CCC;clear:both;">&nbsp;</div>
                <!-- floated element begin -->
                <div style="font-size:small;<if @elements.text_align@ not nil>text-align:@elements.text_align@;</if><if @elements.float@ not nil>float:@elements.float@;clear:right;</if>">
              </else>
                @elements.label;noquote@
              <if @form_properties.show_required_p@ true>
                <if @elements.optional@ nil and @elements.mode@ ne "display" and @elements.widget@ ne "inform" and @elements.widget@ ne "hidden" and @elements.widget@ ne "submit">  <span class="form-required-mark">*</span></if>
              </if>
              <if @elements.section@ not nil>
                </div>
              </if>
            </if>
            <else>
	      <if @elements.section@ nil><div style="background-color:#CCC;clear:both;">&nbsp;</div></if>
              <!-- not floated element begin -->
              <div style="font-size:small;<if @elements.text_align@ not nil>text-align:@elements.text_align@;</if><if @elements.float@ not nil>float:@elements.float@;</if>">
              @elements.label;noquote@
              <if @form_properties.show_required_p@ true>
                <if @elements.optional@ nil and @elements.mode@ ne "display" and @elements.widget@ ne "inform" and @elements.widget@ ne "hidden" and @elements.widget@ ne "submit"><span class="form-required-mark">*</span></if>
              </if>
              </div>
            </else>
          </if>
          <else>
            <noparse>
              <if \@formerror.@elements.id@\@ not nil>
                <div class="form-label-error">
              </if>
              <else>
                <div>
              </else>
            </noparse>
          </else>
            <noparse>
              <if \@formerror.@elements.id@\@ not nil>
                <div class="form-widget-error">
              </if>
            </noparse>
          <if @elements.widget@ eq radio or @elements.widget@ eq checkbox>
             <noparse>
               <div style="float:<if @elements.float@ not nil>@elements.float@</if><else>right</else>;">
                 <formgroup id="@elements.id@">
                   <div style="float:<if @elements.float@ not nil>@elements.float@</if><else>right</else>;">
                     \@formgroup.widget;noquote@<label for="@elements.form_id@:elements:@elements.id@:\@formgroup.option@">\@formgroup.label;noquote@</label></div>
                 </formgroup>
                   </div>
             </noparse>
          </if>
          <else>
            <noparse><formwidget id="@elements.id@"></noparse>
          </else>
          <noparse>
            <formerror id="@elements.id@">
              <div class="form-error">
                \@formerror.@elements.id@;noquote\@
              <!-- error element end --></div>
            </formerror>
          </noparse>
          <if @elements.float@ not nil and @elements.section@ not nil>
	    <!-- floated and sectioned element end -->
            </li>
	    <!-- section end -->
          </if>
	  <if @elements.float@ nil and @elements.section@ not nil>
	               </div>
	        <!-- sectioned element end -->
	  </if>
          <if @elements.section@ nil and @elements.float@ not nil>
                       </div>
                <!-- floated element end -->
          </if>
        </else>

        <if @elements.help_text@ not nil and @elements.mode@ ne "display">
          <div style="clear:left;padding-top:20px;font-size:x-small;color:grey;">
            <img src="/shared/images/info.gif" width="12" height="9" alt="[i]" title="Help text" border="0" />
            <noparse><formhelp id="@elements.id@"></noparse>
          </div>
        </if>
      
      </else>
    </group>
    <if @elements.float@ not nil and @elements.section@ not nil></ul></if>
    <if @elements.section@ not nil></div>
      <!-- section end -->
    </if>
  </multiple>
</td></tr></table>

<multiple name="elements">
  <if @form_properties.show_required_p@ true>
    <if @elements.optional@ nil and @elements.mode@ ne "display" and @elements.widget@ ne "inform" and @elements.widget@ ne "hidden" and @elements.widget@ ne "submit">
       <span class="form-required-mark">*</span> #acs-templating.required# <% break %>
    </if>
  </if>
</multiple>