/* ****************************************************************************
* $Revision: 74556 $:
* $Author: pisan.jariyasettachok $:
* $Date: 2020-08-19 15:56:38 +0700 (Wed, 19 Aug 2020) $:
* $HeadURL: http://svn01.rapidesuite.com:999/svn/a/dev/rapidesuite/controldata/FUSION_11.1.13/trunk/core/reverse_sql/FINANCIALS/Manage%20HCM%20Atom%20Feeds%20-%20Atom%20Feeds.sql $:
* $Id: Manage HCM Atom Feeds - Atom Feeds.sql 74556 2020-08-19 08:56:38Z pisan.jariyasettachok $:
* ****************************************************************************
* Description:
* ************************************************************************** */

-- RSC_PREREQUISITE_OBJECTS=HRC_ATOMPUB_COLLECTIONS
-- RSC_PREREQUISITE_OBJECTS=HRC_ATOMPUB_EVT_ATTRS

SELECT achPursE0.TITLE RES_TITLE
,(SELECT DISPLAY_NAME FROM HRC_EVT_SOURCE_OBJECTS WHERE SOURCE_OBJECT_ID = hrcatomevtE0.SOURCE_OBJECT_ID) RES_SOURCEOBJECTNAME
,(SELECT NAME FROM HRC_EVT_SRC_OBJ_ATTRIBUTES WHERE SOURCE_OBJECT_ATTRIBUTE_ID = hrcatomevtE0.SOURCE_OBJECT_ATTRIBUTE_ID
	AND SOURCE_OBJECT_ID = hrcatomevtE0.SOURCE_OBJECT_ID AND hrcatomevtE0.DELETED_FLAG = 'Y') RES_AVAILABLE_ATTRIBUTES
,(SELECT NAME FROM HRC_EVT_SRC_OBJ_ATTRIBUTES WHERE SOURCE_OBJECT_ATTRIBUTE_ID = hrcatomevtE0.SOURCE_OBJECT_ATTRIBUTE_ID
	AND SOURCE_OBJECT_ID = hrcatomevtE0.SOURCE_OBJECT_ID AND hrcatomevtE0.DELETED_FLAG = 'N') RES_SELECTED_ATTRIBUTES

, hrcatomevtE0.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
, hrcatomevtE0.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
, hrcatomevtE0.CREATED_BY RSC_CREATED_BY
, hrcatomevtE0.CREATION_DATE RSC_CREATION_DATE
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
,(SELECT DISTINCT COLLECTION_ID,SOURCE_OBJECT_ID,SOURCE_OBJECT_ATTRIBUTE_ID,DELETED_FLAG
	,LAST_UPDATED_BY,LAST_UPDATE_DATE,CREATED_BY,CREATION_DATE FROM HRC_ATOMPUB_EVT_ATTRS)  hrcatomevtE0
WHERE achPursE0.ATOM_ID = workSpacesE0.ATOM_ID
AND achPursE0.COLLECTION_ID  = hrcatomevtE0.COLLECTION_ID 
ORDER BY achPursE0.TITLE,RES_SOURCEOBJECTNAME,RES_AVAILABLE_ATTRIBUTES,RES_SELECTED_ATTRIBUTES