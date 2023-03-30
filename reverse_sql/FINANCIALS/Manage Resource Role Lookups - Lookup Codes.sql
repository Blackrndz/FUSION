/* ****************************************************************************
 * $Revision: 78229 $:
 * $Author: pisan.jariyasettachok $:
 * $Date: 2022-04-07 14:37:05 +0700 (Thu, 07 Apr 2022) $:
 * $HeadURL: https://svn03.rapid4cloud.com/svn/a/dev/rapidesuite/controldata/FUSION_11.1.13/trunk/core/reverse_sql/FINANCIALS/Manage%20Resource%20Role%20Lookups%20-%20Lookup%20Codes.sql $:
 * $Id: Manage Resource Role Lookups - Lookup Codes.sql 78229 2022-04-07 07:37:05Z pisan.jariyasettachok $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */
 


select 
LookupValueTranslationEO.LOOKUP_TYPE                            RES_LOOKUP_TYPE,
LOOKUP_CODE                                                     RES_LOOKUP_CODE,
DISPLAY_SEQUENCE                                                RES_DISPLAY_SEQUENCE,
decode(ENABLED_FLAG,'Y','Yes','No')                             RES_ENABLED,
to_char(START_DATE_ACTIVE,'DD-Mon-YYYY')                        RES_START_DATE,
to_char(END_DATE_ACTIVE,'DD-Mon-YYYY')                          RES_END_DATE,
MEANING                                                         RES_MEANING,
DESCRIPTION                                                     RES_DESCRIPTION,
TAG                                                             RES_TAG
,LookupValueTranslationEO.LAST_UPDATED_BY  RSC_LAST_UPDATED_BY
,LookupValueTranslationEO.LAST_UPDATE_DATE  RSC_LAST_UPDATE_DATE
,LookupValueTranslationEO.CREATED_BY  RSC_CREATED_BY
,LookupValueTranslationEO.CREATION_DATE  RSC_CREATION_DATE
,null RSC_LEDGER_ID
,null RSC_CHART_OF_ACCOUNTS_ID
,null RSC_BUSINESS_UNIT_ID
,null RSC_LEGAL_ENTITY_ID
,null RSC_ORGANIZATION_ID
,null RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM Fusion.FND_LOOKUP_VALUES_VL  LookupValueTranslationEO
WHERE LOOKUP_TYPE= 'JTF_RS_ROLE_TYPE'
ORDER BY LookupValueTranslationEO.LOOKUP_TYPE ,DISPLAY_SEQUENCE