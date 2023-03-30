/* ****************************************************************************
 * $Revision: 78229 $:
 * $Author: pisan.jariyasettachok $:
 * $Date: 2022-04-07 14:37:05 +0700 (Thu, 07 Apr 2022) $:
 * $HeadURL: https://svn03.rapid4cloud.com/svn/a/dev/rapidesuite/controldata/FUSION_11.1.13/trunk/core/reverse_sql/FINANCIALS/Manage%20Service%20Provider%20Relationships%20-%20Procurement%20Service%20Providers.sql $:
 * $Id: Manage Service Provider Relationships - Procurement Service Providers.sql 78229 2022-04-07 07:37:05Z pisan.jariyasettachok $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */
 
SELECT    ( select AAA.BU_NAME  
			from  FUN_ALL_BUSINESS_UNITS_V AAA
			where  AAA.BU_ID =  BUServiceProviderEO.CLIENT_BU_ORG_ID
		  )       RES_BUSINESS_UNIT
        , BusinessUnitPEO.BU_NAME                                       RES_NAME
        , DECODE(BUServiceProviderEO.ACTIVE_FLAG,'Y','Yes','No')    RES_ACTIVE
		, BUServiceProviderEO.LAST_UPDATED_BY  RSC_LAST_UPDATED_BY
		, BUServiceProviderEO.LAST_UPDATE_DATE  RSC_LAST_UPDATE_DATE
		, BUServiceProviderEO.CREATED_BY  RSC_CREATED_BY
		, BUServiceProviderEO.CREATION_DATE  RSC_CREATION_DATE
		, null RSC_LEDGER_ID
		, null RSC_CHART_OF_ACCOUNTS_ID
		, BUServiceProviderEO.CLIENT_BU_ORG_ID RSC_BUSINESS_UNIT_ID
		, null RSC_LEGAL_ENTITY_ID
		, null RSC_ORGANIZATION_ID
		, null RSC_BUSINESS_GROUP_ID
		, NULL RSC_ENTERPRISE_ID
, NULL RSC_COUNTRY_ID

FROM      FUN_BU_SERVICE_PROVIDERS BUServiceProviderEO
        , FUN_ALL_BUSINESS_UNITS_V BusinessUnitPEO
        , FUN_BUSINESS_FUNCTIONS_VL UpstreamBusinessFunction
        , FUN_BUSINESS_FUNCTIONS_VL DownstreamBusinessFunction
WHERE     BUServiceProviderEO.PROVIDER_BU_ORG_ID              = BusinessUnitPEO.BU_ID
          AND UpstreamBusinessFunction.BUSINESS_FUNCTION_ID   = BUServiceProviderEO.UPSTREAM_FUNCTION_ID
          AND DownstreamBusinessFunction.BUSINESS_FUNCTION_ID = BUServiceProviderEO.DOWNSTREAM_FUNCTION_ID
          AND
          (
                    UpstreamBusinessFunction.BUSINESS_FUNCTION_CODE = 'REQUISITIONING_BF'
          )
          AND
          (
                    DownstreamBusinessFunction.BUSINESS_FUNCTION_CODE = 'PROCUREMENT_BF'
          )
ORDER BY  BUServiceProviderEO.ACTIVE_FLAG DESC
        , BusinessUnitPEO.BU_NAME

