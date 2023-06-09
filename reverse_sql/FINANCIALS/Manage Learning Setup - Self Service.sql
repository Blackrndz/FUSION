/* ****************************************************************************
 * $Revision:  $:
 * $Author: Nasrullah Dusenmahamad $:
 * $Date: 2018-03-20  $:
 * $HeadURL: $:
 * $Id: Configure Exception Sets - Exception  $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */
 
-- RSC_PREREQUISITE_OBJECTS=WLF_PROPERTIES

SELECT (CASE
	WHEN EXISTS (SELECT 1 FROM WLF_PROPERTIES
		WHERE NAME = 'SELF_SERVICE_BROWSE_MODE'
		AND VALUE = 'SELF_SERVICE_DEPRECATED_OLD_BROWSE_CATALOG') THEN
			'Deprecated Old Browse Catalog'
	WHEN EXISTS (SELECT 1 FROM WLF_PROPERTIES
		WHERE NAME = 'SELF_SERVICE_BROWSE_MODE'
		AND VALUE = 'SELF_SERVICE_ENABLE_NEW_BROWSE_BY') THEN
			'New Browse Catalog By'
	ELSE
	/*WHEN EXISTS (SELECT 1 FROM WLF_PROPERTIES
		WHERE NAME = 'SELF_SERVICE_BROWSE_MODE'
		AND VALUE = 'SELF_SERVICE_DISABLE_BROWSE_CATALOG') THEN*/
			'Disable Browse'
	END)RES_CONFIGURE_BROWSE_LEARNING_
,(CASE
	WHEN EXISTS (SELECT 1 FROM WLF_PROPERTIES
		WHERE NAME = 'SELF_SERVICE_BROWSE_MODE'
		AND VALUE = 'SELF_SERVICE_ENABLE_NEW_BROWSE_BY') THEN
		(SELECT DECODE(VALUE,'Y','Yes','No')
			FROM WLF_PROPERTIES
			WHERE NAME = 'SELF_SERVICE_FEATURED_LEARNING')
	END) RES_FEATURED_LEARNING
,(CASE
	WHEN EXISTS (SELECT 1 FROM WLF_PROPERTIES
		WHERE NAME = 'SELF_SERVICE_BROWSE_MODE'
		AND VALUE = 'SELF_SERVICE_ENABLE_NEW_BROWSE_BY') THEN
		(SELECT DECODE(VALUE,'Y','Yes','No')
			FROM WLF_PROPERTIES
			WHERE NAME = 'SELF_SERVICE_HIGHEST_RATED')
	END) RES_HIGHEST_RATED
/*
,(CASE
	WHEN EXISTS (SELECT 1 FROM WLF_PROPERTIES
		WHERE NAME = 'SELF_SERVICE_BROWSE_MODE'
		AND VALUE = 'SELF_SERVICE_ENABLE_NEW_BROWSE_BY') THEN
		(SELECT DECODE(VALUE,'Y','Yes','No')
			FROM WLF_PROPERTIES
			WHERE NAME = 'SELF_SERVICE_HIGHEST_RATED')
	END) "Categories"


-- Available Offerings

,(SELECT DECODE(VALUE,'Y','Yes','No')
	FROM WLF_PROPERTIES
	WHERE NAME = 'SELF_SERVICE_ENABLE_DEFAULT_LANGUAGE'
	) "Set the language filter to a user's preferred language when they are in the available offerings list view."
*/


-- HCM Cloud Mobile Related Profile Options
/*The data defined and can be change from --> Manage Administrator Profile Values*/

,(CASE
	WHEN EXISTS (SELECT 1 FROM WLF_PROPERTIES
		WHERE NAME = 'SELF_SERVICE_BROWSE_MODE'
		AND VALUE = 'SELF_SERVICE_ENABLE_NEW_BROWSE_BY') THEN
		(SELECT DECODE(VALUE,'Y','Yes','No')
			FROM WLF_PROPERTIES
			WHERE NAME = 'SELF_SERVICE_HIGHEST_RATED')
	END) RES_CATEGORIES
,(SELECT DECODE(VALUE,'Y','Yes','No')
	FROM WLF_PROPERTIES
	WHERE NAME = 'SELF_SERVICE_ENABLE_DEFAULT_LANGUAGE'
	)  RES_SET_THE_LANGUAGE_FILTER_TO

,'' RES_HCM_MOBILE_LEARN_SYNC_INTE
,'' RES_HCM_MOBILE_ENABLE_OFFLINE_
,'' RES_HCM_MOBILE_ENABLE_WELLNESS
,'' RES_HCM_MOBILE_ACTIVE_LEARNING
,'' RES_HCM_MOBILE_COMPLETED_LEARN
,'' RES_HCM_MOBILE_ENABLE_NATIVE_A
,'' RES_HCM_MOBILE_IDLE_TIMEOUT
,'' RES_HCM_MOBILE_OFFLINE_LEARN
,'' RES_HCM_MOBILE_OFFLINE_LEARNIN
,'' RES_HCM_MOBILE_SESSION_TIMEOUT

,setupsE0.LAST_UPDATED_BY  RSC_LAST_UPDATED_BY
,setupsE0.LAST_UPDATE_DATE  RSC_LAST_UPDATE_DATE
,setupsE0.CREATED_BY  RSC_CREATED_BY
,setupsE0.CREATION_DATE  RSC_CREATION_DATE
,null RSC_LEDGER_ID
,null RSC_CHART_OF_ACCOUNTS_ID
,null RSC_BUSINESS_UNIT_ID
,null RSC_LEGAL_ENTITY_ID
,null RSC_ORGANIZATION_ID
,null RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM (SELECT LAST_UPDATED_BY
	,LAST_UPDATE_DATE
	,CREATED_BY
	,CREATION_DATE 
	,ROW_NUMBER() OVER (ORDER BY LAST_UPDATE_DATE DESC) R1
	FROM WLF_PROPERTIES 
	) setupsE0
WHERE R1 = 1