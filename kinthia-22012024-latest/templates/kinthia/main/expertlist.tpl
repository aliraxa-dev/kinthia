<div class="row expert-list-row">
    {if $voyants|@count == 0}
        <div class="col-lg-12">
            <div class="expert-empty bg-grey-expert">
                <h1 class="expert-empty-message">No Experts Found</h1>
            </div>
        </div>
    {/if}
    {foreach from=$voyants value=voyant}
    <div class="col-lg-12">
        <div class="expert-container {cycle values='bg-grey-expert,'}">
            <div class="expert-description">
                <div>
                    <h2 class="expert-h2">{$voyant.headerDescription}</h2>
                    {if $voyant.ratingAverage > 0}
                        <div class="average-rating">
                            <span class="average-rating-star"></span>
                            {$voyant.ratingAverage}
                        </div>
                    {/if}
                </div>
                <div class="text-description">
                    {if !empty($voyant.shortDescription)}
                    «{$voyant.shortDescription|htmlspecialchars_decode}»
                    {/if}
                </div>
                <div class="expert-stats">
                    <div class="expert-stats-cons"><b>{$voyant.answeredCount}</b> consultations</div>
                    <div class="expert-stats-avis"><b>{$voyant.voyantCommentValidatedCount}</b> avis</div>
                </div>
            </div>
            <div class="expert-image">
                {if isset($voyant.imageSrc)}
                    <a href="{$voyant|objurl:'voyantDetails'}"><img src="{$voyant.imageSrc|realImgSrc:'voyant':'small'}" alt="{$voyant.headerDescription}" class="expert-img" width="77px" height="99px" /></a>
                {else}
                    <a href="{$voyant|objurl:'voyantDetails'}"><img src="{$voyant.firstGalleryImageSrc|realImgSrc:'voyant':'small'}" alt="{$voyant.headerDescription}" class="expert-img" width="77px" height="99px" /></a>
                {/if}
            </div>

            <!-- START - Expert Action -->
            <div class="expert-action">
                <div class="expert-action-line">
                    <div class="expert-action-icon">
                        <!-- logged / webcam ON / expert is not in consultation -->
                        {if $voyant.displayWebcam && $voyant.consultationStatus=="ON"}
                            {assign var="mUrl" value="/consultation/start/".$voyant.voyantId."/webcam"}
                            <a id="startConsultation-webcam" href="{$mUrl|url}" class="status-wrapper webcam present typ" title="Webcam"></a>

                        <!-- logged / webcam ON / audio Off / waiting for consultation response -->
                        {elseif $voyant.displayWebcam && $voyant.consultationStatus=="P"}
                            <div class="status-wrapper webcam busy">
                                <div class="status-display">
                                    <span class="status-display-text">En consultation</span><br>
                                </div>
                            </div>

                        <!-- logged / webcam ON / In consultation -->
                        {elseif $voyant.displayWebcam && $voyant.consultationStatus=="B"}
                            <div class="status-wrapper webcam busy">
                                <div class="status-display">
                                    <span class="status-display-text">En consultation</span><br>
                                        depuis <span class="status-display-time clock_{$voyant.voyantId}">
                                        <input type="hidden" class="cHour_{$voyant.voyantId}" value="{$voyant.consultationTime|date_format:'%H'}">
                                        <input type="hidden" class="cMin_{$voyant.voyantId}" value="{$voyant.consultationTime|date_format:'%M'}">
                                        <input type="hidden" class="cSec_{$voyant.voyantId}" value="{$voyant.consultationTime|date_format:'%S'}">
                                    </span>
                                </div>
                            </div>

                        <!-- logged / webcam OFF / expert is offline -->
                        {elseif (($voyant.displayWebcam==0) || empty($voyant.displayWebcam)) && $voyant.consultationStatus=="OF"}
                            <div class="status-wrapper webcam offline"></div>

                        <!-- unlogged / webcam ON / expert is offline -->
                        {elseif $voyant.displayWebcam}
                            <div class="status-wrapper webcam offline"></div>

                        {else}
                            <div class="status-wrapper webcam disable"></div>

                        {/if}
                    </div>
                    <div class="expert-action-icon">
                        <!-- logged / audio ON / expert is not in consultation -->
                        {if $voyant.displayPhone && $voyant.consultationStatus=="ON"}
                            {assign var="pUrl" value="/consultation/start/".$voyant.voyantId."/phone"}
                            <a id="startConsultation-phone" href="{$pUrl|url}" class="status-wrapper phone present typ" title="Tél"></a>

                        <!-- logged / webcam ON / audio off / expert is not in consultation -->
                        {elseif $voyant.displayWebcam && $voyant.consultationStatus=="ON"}
                            <div class="status-wrapper phone offline"></div>

                        <!-- logged / audio on / waiting for consultation response -->
                        {elseif $voyant.displayPhone && $voyant.consultationStatus=="P"}
                            <div class="status-wrapper phone busy">
                                <div class="status-display">
                                    <span class="status-display-text">En consultation</span><br>
                                </div>
                            </div>

                        <!-- user loggedIn && Webcam on && audio off && waiting for consultation response -->
                        {elseif $voyant.displayWebcam && $voyant.consultationStatus=="P"}
                            <div class="status-wrapper phone offline"></div>

                        <!-- logged / audio ON / In consultation -->
                        {elseif $voyant.displayPhone && $voyant.consultationStatus=="B"}
                            <div class="status-wrapper phone busy">
                                <div class="status-display">
                                    <span class="status-display-text">En consultation</span><br>
                                    depuis
                                    <span class="status-display-time clock_{$voyant.voyantId}">
                                        <input type="hidden" class="cHour_{$voyant.voyantId}" value="{$voyant.consultationTime|date_format:'%H'}">
                                        <input type="hidden" class="cMin_{$voyant.voyantId}" value="{$voyant.consultationTime|date_format:'%M'}">
                                        <input type="hidden" class="cSec_{$voyant.voyantId}" value="{$voyant.consultationTime|date_format:'%S'}">
                                    </span>
                                </div>
                            </div>

                        <!-- logged / webcam ON / audio off / In consultation -->
                        {elseif $voyant.displayWebcam && $voyant.consultationStatus=="B"}
                            <div class="status-wrapper phone offline"></div>

                        <!-- logged / audio OFF / expert is offline -->
                        {elseif (($voyant.displayPhone==0) || empty($voyant.displayPhone)) && $voyant.consultationStatus=="OF"}
                            <div class="status-wrapper phone offline"></div>

                        <!-- unlogged / audio ON / expert is offline -->
                        {elseif $voyant.displayPhone}
                            <div class="status-wrapper phone offline"></div>

                        {else}
                            <div class="status-wrapper phone disable"></div>

                        {/if}
                    </div>
                </div>
                <div class="expert-action-line">
                    <div class="expert-action-icon">
                        <!-- logged / chat ON / expert is not in consultation -->
                        {if $voyant.displayChat && $voyant.consultationStatus=="ON"}
                            {assign var="mUrl" value="/consultation/start/".$voyant.voyantId."/chat"}
                            <a id="startConsultation-chat" href="{$mUrl|url}" class="status-wrapper chat present typ" title="Chat"></a>

                            <!-- logged / chat ON / audio Off / waiting for consultation response -->
                        {elseif $voyant.displayChat && $voyant.consultationStatus=="P"}
                            <div class="status-wrapper chat busy">
                                <div class="status-display">
                                    <span class="status-display-text">En consultation</span><br>
                                </div>
                            </div>

                            <!-- logged / chat ON / In consultation -->
                        {elseif $voyant.displayChat && $voyant.consultationStatus=="B"}
                            <div class="status-wrapper chat busy">
                                <div class="status-display">
                                    <span class="status-display-text">En consultation</span><br>
                                    depuis <span class="status-display-time clock_{$voyant.voyantId}">
                                        <input type="hidden" class="cHour_{$voyant.voyantId}" value="{$voyant.consultationTime|date_format:'%H'}">
                                        <input type="hidden" class="cMin_{$voyant.voyantId}" value="{$voyant.consultationTime|date_format:'%M'}">
                                        <input type="hidden" class="cSec_{$voyant.voyantId}" value="{$voyant.consultationTime|date_format:'%S'}">
                                    </span>
                                </div>
                            </div>

                            <!-- logged / chat OFF / expert is offline -->
                        {elseif (($voyant.displayChat==0) || empty($voyant.displayChat)) && $voyant.consultationStatus=="OF"}
                            <div class="status-wrapper chat offline"></div>

                            <!-- unlogged / chat ON / expert is offline -->
                        {elseif $voyant.displayChat}
                            <div class="status-wrapper chat offline"></div>

                        {else}
                            <div class="status-wrapper chat disable"></div>

                        {/if}
                    </div>
                    <div class="expert-action-icon">
                        {if $voyant.displayEmail}
                            <a href="{$voyant|objurl:'voyantDetails'}" class="status-wrapper email present" title="Email"></a>
                        {else}
                            <div class="status-wrapper email disable"></div>
                        {/if}
                    </div>
                </div>
                <div class="expert-current-status">
                    {if $voyant.available == 1}
                    Disponible
                    {else}
                    Indisponible
                    {/if}
                </div>
            </div>
            <!-- END - Expert Action -->
        </div>
    </div>
    {/foreach}
</div>
