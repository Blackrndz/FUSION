/* ****************************************************************************
* $Revision: 78229 $:
* $Author: pisan.jariyasettachok $:
* $Date: 2022-04-07 14:37:05 +0700 (Thu, 07 Apr 2022) $:
* $HeadURL: https://svn03.rapid4cloud.com/svn/a/dev/rapidesuite/controldata/FUSION_11.1.13/trunk/core/reverse_sql/FINANCIALS/Manage%20HCM%20Atom%20Feeds%20-%20Atom%20Feeds.sql $:
* $Id: Manage HCM Atom Feeds - Atom Feeds.sql 78229 2022-04-07 07:37:05Z pisan.jariyasettachok $:
* ****************************************************************************
* Description:
* ************************************************************************** */

-- RSC_PREREQUISITE_OBJECTS=HRC_ATOMPUB_COLLECTIONS

SELECT '' RES_CRITERIA_OPTION
,achPursE0.TITLE RES_TITLE
,achPursE0.SUBTITLE RES_SUBTITLE
,achPursE0.LAST_UPDATE_DATE RES_LAST_UPDATED

,workSpacesE0.TITLE RES_WORKSPACE_MEMBERSHIPS

,'' RES_RIGHTS
,'' RES_SECURING_OBJECT
,'' RES_ACCEPT_ENTRIES

,'' RES_ARCHIVE
,DECODE(achPursE0.ARCHIVE_PERIOD_TYPE
    ,'minutes','Minutes'
    ,'hours','Hours'
    ,'days','Days'
    ,'weeks','Weeks'
    ,'months','Months'
    ,'years','Years'
    ) RES_ARCHIVE_PERIOD_TYPE
,achPursE0.ARCHIVE_PERIOD_VALUE RES_ARCHIVE_PERIOD_VALUE
,DECODE(achPursE0.ARCHIVE_APPLY_TO
    ,'all','All'
    ,'new','New'
    ) RES_ARCHIVE_APPLY_TO
,'' RES_ICON
,'' RES_LOGO
,DECODE(achPursE0.ENABLED_FLAG,'Y','Yes','No') RES_ENABLED

,'' RES_PURGE
,DECODE(achPursE0.PURGE_PERIOD_TYPE
    ,'minutes','Minutes'
    ,'hours','Hours'
    ,'days','Days'
    ,'weeks','Weeks'
    ,'months','Months'
    ,'years','Years'
    ) RES_PURGE_PERIOD_TYPE
,achPursE0.PURGE_PERIOD_VALUE RES_PURGE_PERIOD_VALUE
,DECODE(achPursE0.PURGE_APPLY_TO
    ,'all','All'
    ,'new','New'
    ) RES_PURGE_APPLY_TO


, achPursE0.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
, achPursE0.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
, achPursE0.CREATED_BY RSC_CREATED_BY
, achPursE0.CREATION_DATE RSC_CREATION_DATE
, NULL RSC_LEDGER_ID
, NULL RSC_CHART_OF_ACCOUNTS_ID
, NULL RSC_BUSINESS_UNIT_ID
, NULL RSC_LEGAL_ENTITY_ID
, NULL RSC_ORGANIZATION_ID
, NULL RSC_BUSINESS_GROUP_ID
, NULL RSC_ENTERPRISE_ID
, NULL RSC_COUNTRY_ID


FROM HRC_ATOMPUB_ENTRIES workSpacesE0
,(SELECT pubCollectionsE0.COLLECTION_ID
    ,pubCollectionsE0.TITLE
    ,pubCollectionsE0.SECURITY_TYPE
    ,EXTRACTVALUE(XMLTYPE.CREATEXML(pubCollectionsE0.COLLECTION_XML)
        ,'feed/subtitle'
        ,'xmlns="http://www.w3.org/2005/Atom"'
        ) SUBTITLE
    ,EXTRACTVALUE(XMLTYPE.CREATEXML(pubCollectionsE0.SETTINGS_XML)
        ,'fext:collectionSettings/archive/@periodType'
        ,'xmlns:fext="http://xmlns.oracle.com/apps/hcmCommon/core/atom/fext"'
        ) ARCHIVE_PERIOD_TYPE
    ,EXTRACTVALUE(XMLTYPE.CREATEXML(pubCollectionsE0.SETTINGS_XML)
        ,'fext:collectionSettings/archive/@periodValue'
        ,'xmlns:fext="http://xmlns.oracle.com/apps/hcmCommon/core/atom/fext"'
        ) ARCHIVE_PERIOD_VALUE
    ,EXTRACTVALUE(XMLTYPE.CREATEXML(pubCollectionsE0.SETTINGS_XML)
        ,'fext:collectionSettings/archive/@apply'
        ,'xmlns:fext="http://xmlns.oracle.com/apps/hcmCommon/core/atom/fext"'
        ) ARCHIVE_APPLY_TO
    ,EXTRACTVALUE(XMLTYPE.CREATEXML(pubCollectionsE0.SETTINGS_XML)
        ,'fext:collectionSettings/purge/@periodType'
        ,'xmlns:fext="http://xmlns.oracle.com/apps/hcmCommon/core/atom/fext"'
        ) PURGE_PERIOD_TYPE
    ,EXTRACTVALUE(XMLTYPE.CREATEXML(pubCollectionsE0.SETTINGS_XML)
        ,'fext:collectionSettings/purge/@periodValue'
        ,'xmlns:fext="http://xmlns.oracle.com/apps/hcmCommon/core/atom/fext"'
        ) PURGE_PERIOD_VALUE
    ,EXTRACTVALUE(XMLTYPE.CREATEXML(pubCollectionsE0.SETTINGS_XML)
        ,'fext:collectionSettings/purge/@apply'
        ,'xmlns:fext="http://xmlns.oracle.com/apps/hcmCommon/core/atom/fext"'
        ) PURGE_APPLY_TO
    ,EXTRACTVALUE(XMLTYPE.CREATEXML(pubCollectionsE0.SETTINGS_XML)
        ,'fext:collectionSettings/workspaceMember'
        ,'xmlns:fext="http://xmlns.oracle.com/apps/hcmCommon/core/atom/fext"'
        ) ATOM_ID
	,pubCollectionsE0.ENABLED_FLAG
	,LAST_UPDATED_BY
	,LAST_UPDATE_DATE
	,CREATED_BY
	,CREATION_DATE
    FROM HRC_ATOMPUB_COLLECTIONS pubCollectionsE0
    ) achPursE0
WHERE achPursE0.ATOM_ID = workSpacesE0.ATOM_ID