environments {
    development {
    }
    test {
    }
    production {
        dataSource {
            dbCreate = "update"
            username = System.getenv("WEBAPOLLO_DB_USERNAME")
            password = System.getenv("WEBAPOLLO_DB_PASSWORD")

            driverClassName = "org.postgresql.Driver"
            dialect = "org.hibernate.dialect.PostgresPlusDialect"
            url = System.getenv("WEBAPOLLO_DB_URI")

            properties {
                // See http://grails.org/doc/latest/guide/conf.html#dataSource for documentation
                jmxEnabled = false
                initialSize                   = 5
                maxActive                     = 50
                minIdle                       = 5
                maxIdle                       = 25
                maxWait                       = 10000
                maxAge                        = 10 * 60000
                timeBetweenEvictionRunsMillis = 5000
                minEvictableIdleTimeMillis    = 60000
                validationQuery               = "SELECT 1"
                validationQueryTimeout        = 3
                validationInterval            = 15000
                testOnBorrow = true
                testWhileIdle = true
                testOnReturn = false
                jdbcInterceptors = "ConnectionState"
                defaultTransactionIsolation = java.sql.Connection.TRANSACTION_READ_COMMITTED
            }
        }
        dataSource_chado {
            dbCreate = "update" // one of 'create', 'create-drop', 'update', 'validate', ''
            username = System.getenv("WEBAPOLLO_CHADO_DB_USERNAME")
            password = System.getenv("WEBAPOLLO_CHADO_DB_PASSWORD")

            driverClassName = "org.postgresql.Driver"
            dialect = "org.hibernate.dialect.PostgresPlusDialect"
            url = System.getenv("WEBAPOLLO_CHADO_DB_URI")

            properties {
                // See http://grails.org/doc/latest/guide/conf.html#dataSource for documentation
                jmxEnabled = false
                initialSize                   = 5
                maxActive                     = 50
                minIdle                       = 5
                maxIdle                       = 25
                maxWait                       = 10000
                maxAge                        = 10 * 60000
                timeBetweenEvictionRunsMillis = 5000
                minEvictableIdleTimeMillis    = 60000
                validationQuery               = "SELECT 1"
                validationQueryTimeout        = 3
                validationInterval            = 15000
                testOnBorrow = true
                testWhileIdle = true
                testOnReturn = false
                jdbcInterceptors = "ConnectionState"
                defaultTransactionIsolation = java.sql.Connection.TRANSACTION_READ_COMMITTED
            }
        }
    }
}

apollo {
    default_minimum_intron_size = 1
    history_size                = System.getenv("WEBAPOLLO_HISTORY_SIZE") ? System.getenv("WEBAPOLLO_HISTORY_SIZE").toInteger() : 0
    overlapper_class            = System.getenv("WEBAPOLLO_OVERLAPPER_CLASS") ?: "org.bbop.apollo.sequence.OrfOverlapper"
    use_cds_for_new_transcripts = false
    feature_has_dbxrefs         = true
    feature_has_attributes      = false
    feature_has_pubmed_ids      = false
    feature_has_go_ids          = false
    feature_has_comments        = true
    feature_has_status          = true
    translation_table           = "/config/translation_tables/ncbi_11_translation_table.txt"
    get_translation_code        = 11
    user_pure_memory_store = true
    is_partial_translation_allowed = false // unused so far
    export_subfeature_attrs = true

    // settings for Chado export
    // set chado_export_fasta_for_sequence if you want the reference sequence FASTA to be exported into the database
    // Note: Enabling this feature can be memory intensive
    chado_export_fasta_for_sequence = true
    // set chado_export_fasta_for_cds if you want the CDS FASTA to be exported into the database
    chado_export_fasta_for_cds = false

    // TODO: should come from config or via preferences database
    splice_donor_sites = []
    splice_acceptor_sites = []
    gff3.source = "CPT"

    authentications = [
        [
            "name":"Remote User Authenticator",
            "className":"remoteUserAuthenticatorService",
            "active":true
        ],
        [
            "name":"Username Password Authenticator",
            "className":"usernamePasswordAuthenticatorService",
            "active":true
        ]
    ]

}

jbrowse {
    git {
        url = "https://github.com/GMOD/jbrowse"
        tag = "1.12.2-apollo"
        alwaysPull = true
        alwaysRecheck = true
    }
    plugins {
        WebApollo{
            included = true
        }
        RegexSequenceSearch{
            included = true
        }
        HideTrackLabels{
            included = true
        }
        GCContent {
            git = 'https://github.com/elsiklab/gccontent'
            branch = 'master'
            alwaysRecheck = "true"
            alwaysPull = "true"
        }
        CACAO {
            git = 'https://github.com/TAMU-CPT/cacao-apollo-plugin'
            branch = 'master'
            alwaysRecheck = "true"
            alwaysPull = "true"
        }
    }
}
