import logging
import logging.config
from rich.logging import RichHandler


def logging_configuration():
    return {
        "version": 1,
        "disable_existing_loggers": False,
        "formatters": {
            "long": {
                "format": "%(asctime)s|%(levelname)7s|%(filename)12s:%(lineno)3s| %(message)s",
                "datefmt": "%Y-%m-%d %H:%M:%S",
            }
        },
        "handlers": {
            "console": {
                "class": "logging.StreamHandler",
                "level": "DEBUG",
                "formatter": "long",
                "stream": "ext://sys.stdout",
            },
            "debug_file_handler": {
                "class": "logging.handlers.RotatingFileHandler",
                "level": "DEBUG",
                "formatter": "long",
                "filename": "debug.log",
                "maxBytes": 10485760,
                "backupCount": 5,
                "encoding": "utf8",
            },
            "info_file_handler": {
                "class": "logging.handlers.RotatingFileHandler",
                "level": "INFO",
                "formatter": "long",
                "filename": "info.log",
                "maxBytes": 10485760,
                "backupCount": 20,
                "encoding": "utf8",
            },
            "warn_file_handler": {
                "class": "logging.handlers.RotatingFileHandler",
                "level": "WARNING",
                "formatter": "long",
                "filename": "warn.log",
                "maxBytes": 10485760,
                "backupCount": 20,
                "encoding": "utf8",
            },
            "error_file_handler": {
                "class": "logging.handlers.RotatingFileHandler",
                "level": "ERROR",
                "formatter": "long",
                "filename": "errors.log",
                "maxBytes": 10485760,
                "backupCount": 20,
                "encoding": "utf8",
            },
            "rich_handler": {
                "class": "rich.logging.RichHandler",
                "level": "INFO",
                "formatter": "long",
            },
        },
        "root": {
            "level": "INFO",
            "handlers": [
                # "console",
                "rich_handler",
                "debug_file_handler",
                "info_file_handler",
                "warn_file_handler",
                "error_file_handler",
            ],
        },
    }


def get_logger(name: str = None):
    logger_name = name if name else "unknown"

    conf = logging_configuration()
    logging.config.dictConfig(conf)
    logger = logging.getLogger(logger_name)

    return logger
