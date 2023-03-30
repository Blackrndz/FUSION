/* ****************************************************************************
 * $Revision: 78229 $:
 * $Author: pisan.jariyasettachok $:
 * $Date: 2022-04-07 14:37:05 +0700 (Thu, 07 Apr 2022) $:
 * $HeadURL: https://svn03.rapid4cloud.com/svn/a/dev/rapidesuite/controldata/FUSION_11.1.13/trunk/core/reverse_sql/FINANCIALS/Assign%20Legal%20Entities%20-%20Assign%20Legal%20Entities.sql $:
 * $Id: Assign Legal Entities - Assign Legal Entities.sql 78229 2022-04-07 07:37:05Z pisan.jariyasettachok $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */


select QRSLT.PRIMARY_LEDGER RES_PRIMARY_LEDGER ,
QRSLT.NAME RES_LEGAL_ENTITY,
QRSLT.LEGAL_ENTITY_IDENTIFIER RES_LEGAL_ENTITY_IDENTIFIER,
QRSLT.GEOGRAPHY_NAME RES_COUNTRY,
DECODE(QRSLT.TIME_ZONE_DEFAULT_LE_FLAG,'Y','Yes','N','No')  RES_LEGAL_ENTITY_FOR_DETERMINI 
,QRSLT.LAST_UPDATED_BY  RSC_LAST_UPDATED_BY
,QRSLT.LAST_UPDATE_DATE  RSC_LAST_UPDATE_DATE
,QRSLT.CREATED_BY  RSC_CREATED_BY
,QRSLT.CREATION_DATE  RSC_CREATION_DATE
,QRSLT.LEDGER_ID RSC_LEDGER_ID
,null RSC_CHART_OF_ACCOUNTS_ID
,null RSC_BUSINESS_UNIT_ID
,null RSC_LEGAL_ENTITY_ID
,null RSC_ORGANIZATION_ID
,null RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

from (
select
  GlLedgers.Name PRIMARY_LEDGER,
  GlLedgers.LEDGER_ID,
  GlLedgerConfigDetails.CONFIGURATION_ID,
  GlLedgerConfigDetails.OBJECT_TYPE_CODE,
  GlLedgerConfigDetails.OBJECT_ID,
  GlLedgerConfigDetails.OBJECT_NAME,
  GlLedgerConfigDetails.SETUP_STEP_CODE,
  GlLedgerConfigDetails.NEXT_ACTION_CODE,
  GlLedgerConfigDetails.STATUS_CODE,
  GlLedgerConfigDetails.TIME_ZONE_DEFAULT_LE_FLAG,
  GeographyPEO.GEOGRAPHY_NAME,
  GlLedgerConfigDetails.OBJECT_VERSION_NUMBER,
  GEOGRAPHYPEO.GEOGRAPHY_ID,
  GLLEDGERCONFIGDETAILS.LAST_UPDATED_BY ,
  GlLedgerConfigDetails.last_update_date ,
  GLLEDGERCONFIGDETAILS.CREATED_BY ,
  GlLedgerConfigDetails.CREATION_DATE ,
  XleEntityProfiles.NAME,
  XleEntityProfiles.LEGAL_ENTITY_IDENTIFIER,
  XleEntityProfiles.LEGAL_ENTITY_ID,
  XleEntityProfiles.OBJECT_VERSION_NUMBER AS OBJECT_VERSION_NUMBER1,
  XLEENTITYPROFILES.EFFECTIVE_TO
FROM FUSION.GL_LEDGER_CONFIG_DETAILS GlLedgerConfigDetails,
  FUSION.HZ_GEOGRAPHIES GEOGRAPHYPEO,
  FUSION.XLE_ENTITY_PROFILES XLEENTITYPROFILES ,
  FUSION.GL_LEDGERS  GlLedgers
WHERE ((GeographyPEO.GEOGRAPHY_ID          = XleEntityProfiles.GEOGRAPHY_ID)
AND (GeographyPEO.Geography_type           = 'COUNTRY' ))
AND (XleEntityProfiles.Legal_entity_id     = GlLedgerconfigDetails.Object_id)
AND GlLedgerConfigDetails.Object_type_code = 'LEGAL_ENTITY'
and GLLEDGERCONFIGDETAILS.SETUP_STEP_CODE  = 'NONE'
and GLLEDGERCONFIGDETAILS.CONFIGURATION_ID  =  GLLEDGERS.CONFIGURATION_ID
and GLLEDGERS.LEDGER_CATEGORY_CODE = 'PRIMARY' 
) QRSLT
order by DECODE(QRSLT.TIME_ZONE_DEFAULT_LE_FLAG,'Y',1,'N',2)
,RES_PRIMARY_LEDGER 
,RES_LEGAL_ENTITY
,QRSLT.GEOGRAPHY_NAME